"""Generate Formula/skaldr.rb for the Homebrew tap.

Resolves the runtime closure of skaldr with its publish extra for every Homebrew target
platform (macOS arm64/x64, Linux arm64/x64) and takes the union, then for each package
picks the wheel(s) to pin: pure packages get their single py3-none-any wheel; compiled
packages get, per platform, the best-ranked wheel whose tags CPython 3.13 accepts on that
platform's oldest supported baseline (macOS 11, glibc 2.17), whatever order PyPI lists files
in; generation fails when no wheel qualifies. When some compiled package has no macOS x86_64
wheel (cryptography 50 has none), the formula drops that platform and declares arm64 on
macOS. Emits a formula that installs everything offline from the pre-fetched wheels.

The resolver targets the same glibc floor as the selector (uv's manylinux_2_17 platforms). uv
has no option for a macOS version, so macOS is resolved at uv's default and the selector
enforces the macOS floor, failing when a resolved version has no wheel for it.

Usage: uv run --no-project --with packaging==26.3 python gen-skaldr-formula.py 0.3.0 > skaldr.rb
"""

import json
import subprocess
import sys
import urllib.request

from packaging.tags import compatible_tags, cpython_tags, mac_platforms
from packaging.utils import parse_wheel_filename

PYTHON_DOTTED = "3.13"
PYTHON_VERSION = tuple(int(part) for part in PYTHON_DOTTED.split("."))
INTERPRETER = "cp" + PYTHON_DOTTED.replace(".", "")
OLDEST_MACOS = (11, 0)
OLDEST_GLIBC_MINOR = 17
LOWEST_GLIBC_MINOR_TRIED = 5


def macos_platform_tags(arch):
    return list(mac_platforms(OLDEST_MACOS, arch))


def linux_platform_tags(arch):
    modern = [
        f"manylinux_2_{minor}_{arch}"
        for minor in range(OLDEST_GLIBC_MINOR, LOWEST_GLIBC_MINOR_TRIED - 1, -1)
    ]
    legacy = [f"manylinux2014_{arch}", f"manylinux2010_{arch}", f"manylinux1_{arch}"]
    return modern + legacy


PLATFORMS = {
    ("macos", "arm"): macos_platform_tags("arm64"),
    ("macos", "intel"): macos_platform_tags("x86_64"),
    ("linux", "arm"): linux_platform_tags("aarch64"),
    ("linux", "intel"): linux_platform_tags("x86_64"),
}

UV_PLATFORMS = {
    ("macos", "arm"): "aarch64-apple-darwin",
    ("macos", "intel"): "x86_64-apple-darwin",
    ("linux", "arm"): f"aarch64-manylinux_2_{OLDEST_GLIBC_MINOR}",
    ("linux", "intel"): f"x86_64-manylinux_2_{OLDEST_GLIBC_MINOR}",
}

MACOS_INTEL = ("macos", "intel")


def closure(version):
    """{name: version} for skaldr[publish]==version's runtime closure on every target platform.

    Each platform is resolved on its own, because a dependency can carry a platform marker
    (keyring needs SecretStorage on Linux only); the union holds every package any platform
    installs. --refresh bypasses uv's index cache: right after a release, PyPI has just gained
    this version, and a cached "not found" would otherwise make resolution fail.
    """
    pins = {}
    for uv_platform in UV_PLATFORMS.values():
        out = subprocess.run(
            ["uv", "pip", "compile", "-", "--python-version", PYTHON_DOTTED, "--python-platform", uv_platform,
             "--refresh", "--quiet"],
            input=f"skaldr[publish]=={version}\n", capture_output=True, text=True, check=True,
        ).stdout
        for line in out.splitlines():
            line = line.strip()
            if line and not line.startswith("#"):
                name, _, ver = line.partition("==")
                name, ver = name.strip(), ver.strip()
                if pins.setdefault(name, ver) != ver:
                    raise SystemExit(f"{name} resolves to {pins[name]} and {ver} on different platforms")
    return pins


def files_for(name, version):
    with urllib.request.urlopen(f"https://pypi.org/pypi/{name}/{version}/json") as fh:
        data = json.load(fh)
    return [f for f in data["urls"] if f["packagetype"] == "bdist_wheel"]


def wheel_tags(file):
    return parse_wheel_filename(file["filename"])[3]


def supported_tags_by_preference(platform_tags):
    ordered = list(cpython_tags(PYTHON_VERSION, platforms=platform_tags))
    ordered += compatible_tags(PYTHON_VERSION, interpreter=INTERPRETER, platforms=platform_tags)
    return {tag: rank for rank, tag in reversed(list(enumerate(ordered)))}


def best_ranked(files, rank_of):
    ranked = []
    for f in files:
        ranks = [rank_of[tag] for tag in wheel_tags(f) if tag in rank_of]
        if ranks:
            ranked.append((min(ranks), f["filename"], f))
    return min(ranked, key=lambda entry: entry[:2])[2] if ranked else None


def pure_wheel(files):
    return best_ranked(files, supported_tags_by_preference(["any"]))


def pick_wheel(files, platform_key):
    return best_ranked(files, supported_tags_by_preference(PLATFORMS[platform_key]))


def require_wheel(name, version, files, platform_key):
    wheel = pick_wheel(files, platform_key)
    if not wheel:
        osname, arch = platform_key
        raise SystemExit(f"no {INTERPRETER} wheel installable on {osname}/{arch} for {name} {version}")
    return wheel


def res(name, version, files, platforms):
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
    for osname in ("macos", "linux"):
        lines.append(f"    on_{osname} do")
        for platform_key in platforms:
            platform_os, arch = platform_key
            if platform_os != osname:
                continue
            w = require_wheel(name, version, files, platform_key)
            lines.append(f"      on_{arch} do")
            lines.append(f'        url "{w["url"]}"')
            lines.append(f'        sha256 "{w["digests"]["sha256"]}"')
            lines.append("      end")
        lines.append("    end")
    lines.append("  end")
    return "\n".join(lines) + "\n"


def main(version):
    pins = closure(version)
    skaldr_files = files_for("skaldr", version)
    skaldr_whl = pure_wheel(skaldr_files)

    dependency_files = {name: files_for(name, ver) for name, ver in sorted(pins.items()) if name != "skaldr"}
    for name, files in dependency_files.items():
        if not files:
            raise SystemExit(f"{name} {pins[name]} has no wheels on PyPI; the formula installs wheels only")
    serves_intel_macs = all(
        pure_wheel(files) or pick_wheel(files, MACOS_INTEL) for files in dependency_files.values()
    )
    platforms = [key for key in PLATFORMS if serves_intel_macs or key != MACOS_INTEL]
    resources = [res(name, pins[name], files, platforms) for name, files in dependency_files.items()]
    arm64_on_macos = "" if serves_intel_macs else "  on_macos do\n    depends_on arch: :arm64\n  end\n\n"

    # external:homebrew audit wants depends_on for pyyaml's libyaml; the cop cannot be suppressed
    system_deps = ['  depends_on "libyaml"\n'] if "pyyaml" in pins else []

    print(f'''class Skaldr < Formula
  desc "Render a YAML content file into a self-contained HTML report page"
  homepage "https://github.com/alex-yanchenko/skaldr"
  url "{skaldr_whl["url"]}"
  sha256 "{skaldr_whl["digests"]["sha256"]}"
  license "MIT"

{"".join(system_deps)}  depends_on "python@{PYTHON_DOTTED}"

{arm64_on_macos}{"".join(resources)}
  def install
    system formula_opt_bin("python@{PYTHON_DOTTED}")/"python{PYTHON_DOTTED}", "-m", "venv", libexec
    wheelhouse = buildpath/"wheelhouse"
    wheelhouse.mkpath
    # .whl is not an archive Homebrew unpacks, so cached_download / the staged file IS the
    # wheel. Collect skaldr + every pinned dependency wheel, then install offline.
    cp cached_download, wheelhouse/"skaldr-#{{version}}-py3-none-any.whl"
    resources.each {{ |r| r.stage {{ cp Dir["*.whl"].first, wheelhouse }} }}
    system libexec/"bin/pip", "install", "--no-index", "--find-links", wheelhouse, "skaldr[publish]==#{{version}}"
    bin.install_symlink libexec/"bin/skaldr"
  end

  test do
    system bin/"skaldr", "--help"
    system libexec/"bin/python", "-c", "import authlib, httpx2, keyring, cryptography"
  end
end''')


if __name__ == "__main__":
    main(sys.argv[1])
