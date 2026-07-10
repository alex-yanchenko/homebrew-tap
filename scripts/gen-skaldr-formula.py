"""Generate Formula/skaldr.rb for the Homebrew tap.

Resolves skaldr's runtime closure, then for each package picks the wheel(s) to pin:
pure packages get their single py3-none-any wheel; compiled packages get a cp313 wheel
for each of the four Homebrew target platforms (macOS arm64/x64, Linux arm64/x64).
Emits a formula that installs everything offline from the pre-fetched wheels.

Usage: python gen_skaldr_formula.py 0.3.0 > skaldr.rb
"""

import json
import subprocess
import sys
import urllib.request

VERSION = sys.argv[1]

# (ruby label for on_ block) -> substrings a matching cp313 wheel filename must contain
PLATFORMS = {
    ("macos", "arm"): ["macosx", "arm64"],
    ("macos", "intel"): ["macosx", "x86_64"],
    ("linux", "arm"): ["manylinux", "aarch64"],
    ("linux", "intel"): ["manylinux", "x86_64"],
}


def closure(version):
    """[(name, version)] for skaldr==version's full runtime closure, via uv."""
    out = subprocess.run(
        ["uv", "pip", "compile", "-", "--python-version", "3.13", "--quiet"],
        input=f"skaldr=={version}\n", capture_output=True, text=True, check=True,
    ).stdout
    pins = []
    for line in out.splitlines():
        line = line.strip()
        if line and not line.startswith("#"):
            name, _, ver = line.partition("==")
            pins.append((name.strip(), ver.strip()))
    return pins


def files_for(name, version):
    with urllib.request.urlopen(f"https://pypi.org/pypi/{name}/{version}/json") as fh:
        data = json.load(fh)
    return [f for f in data["urls"] if f["packagetype"] == "bdist_wheel"]


def pure_wheel(files):
    for f in files:
        if f["filename"].endswith("-none-any.whl"):
            return f
    return None


def compiled_wheel(files, needles):
    # cp313 (or stable-ABI abi3) wheel whose filename carries every platform needle
    for f in files:
        fn = f["filename"]
        if ("cp313" in fn or "abi3" in fn) and all(n in fn for n in needles):
            return f
    return None


def res(name, files):
    label = name.replace("-", "_")
    pure = pure_wheel(files)
    if pure:
        return (
            f'  resource "{label}" do\n'
            f'    url "{pure["url"]}"\n'
            f'    sha256 "{pure["digests"]["sha256"]}"\n'
            f"  end\n"
        )
    lines = [f'  resource "{label}" do']
    macos = {k[1]: compiled_wheel(files, v) for k, v in PLATFORMS.items() if k[0] == "macos"}
    linux = {k[1]: compiled_wheel(files, v) for k, v in PLATFORMS.items() if k[0] == "linux"}
    for osname, sel in (("macos", macos), ("linux", linux)):
        lines.append(f"    on_{osname} do")
        for arch in ("arm", "intel"):
            w = sel[arch]
            if not w:
                raise SystemExit(f"no cp313 {osname}/{arch} wheel for {name} {version}")
            lines.append(f"      on_{arch} do")
            lines.append(f'        url "{w["url"]}"')
            lines.append(f'        sha256 "{w["digests"]["sha256"]}"')
            lines.append("      end")
        lines.append("    end")
    lines.append("  end")
    return "\n".join(lines) + "\n"


pins = dict(closure(VERSION))
skaldr_files = files_for("skaldr", VERSION)
skaldr_whl = pure_wheel(skaldr_files)

resources = []
for name, ver in sorted(pins.items()):
    if name == "skaldr":
        continue
    resources.append(res(name, files_for(name, ver)))

# Homebrew's audit requires a depends_on for a resource's known system library. pyyaml maps
# to libyaml; brew forbids suppressing the cop, so declare it. (The wheel bundles its own
# libyaml, so it's unused at runtime, but Homebrew expects the dependency declared.)
system_deps = ['  depends_on "libyaml"\n'] if "pyyaml" in pins else []

print(f'''class Skaldr < Formula
  desc "Render a YAML content file into a self-contained HTML report page"
  homepage "https://github.com/alex-yanchenko/skaldr"
  url "{skaldr_whl["url"]}"
  sha256 "{skaldr_whl["digests"]["sha256"]}"
  license "MIT"

{"".join(system_deps)}  depends_on "python@3.13"

{"".join(resources)}
  def install
    system formula_opt_bin("python@3.13")/"python3.13", "-m", "venv", libexec
    wheelhouse = buildpath/"wheelhouse"
    wheelhouse.mkpath
    # .whl is not an archive Homebrew unpacks, so cached_download / the staged file IS the
    # wheel. Collect skaldr + every pinned dependency wheel, then install offline.
    cp cached_download, wheelhouse/"skaldr-#{{version}}-py3-none-any.whl"
    resources.each {{ |r| r.stage {{ cp Dir["*.whl"].first, wheelhouse }} }}
    system libexec/"bin/pip", "install", "--no-index", "--find-links", wheelhouse, "skaldr==#{{version}}"
    bin.install_symlink libexec/"bin/skaldr"
  end

  test do
    system bin/"skaldr", "--help"
  end
end''')
