import importlib.util
import random
import re
from pathlib import Path

import pytest

SCRIPT = Path(__file__).resolve().parent.parent / "scripts" / "gen-skaldr-formula.py"
spec = importlib.util.spec_from_file_location("gen_skaldr_formula", SCRIPT)
gen = importlib.util.module_from_spec(spec)
spec.loader.exec_module(gen)

CRYPTOGRAPHY_WHEELS = [
    "cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl",
    "cryptography-50.0.2-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl",
    "cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl",
    "cryptography-50.0.2-cp311-abi3-manylinux_2_28_aarch64.whl",
    "cryptography-50.0.2-cp311-abi3-musllinux_1_2_x86_64.whl",
    "cryptography-50.0.2-cp315-abi3.abi3t-macosx_11_0_arm64.whl",
    "cryptography-50.0.2-cp314-cp314t-macosx_11_0_arm64.whl",
    "cryptography-50.0.2-cp39-abi3-manylinux_2_34_aarch64.whl",
    "cryptography-50.0.2-cp39-abi3-manylinux_2_34_x86_64.whl",
    "cryptography-50.0.2-pp311-pypy311_pp80-macosx_11_0_arm64.whl",
]

ALL_PLATFORM_KEYS = [("macos", "arm"), ("macos", "intel"), ("linux", "arm"), ("linux", "intel")]


def listing(filenames):
    return [
        {
            "filename": name,
            "url": f"https://files.example/{name}",
            "digests": {"sha256": f"sha-of-{name}"},
        }
        for name in filenames
    ]


def picked_name(filenames, platform_key):
    picked = gen.pick_wheel(listing(filenames), platform_key)
    return picked["filename"] if picked else None


@pytest.mark.parametrize(
    ("platform_key", "expected"),
    [
        (("macos", "arm"), "cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl"),
        (
            ("linux", "intel"),
            "cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl",
        ),
        (
            ("linux", "arm"),
            "cryptography-50.0.2-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl",
        ),
    ],
)
def test_picks_the_wheel_installable_on_the_oldest_baseline(platform_key, expected):
    assert picked_name(CRYPTOGRAPHY_WHEELS, platform_key) == expected


@pytest.mark.parametrize("platform_key", [("macos", "arm"), ("linux", "intel"), ("linux", "arm")])
def test_choice_is_the_same_for_fifty_seeded_shuffles(platform_key):
    expected = picked_name(CRYPTOGRAPHY_WHEELS, platform_key)
    for seed in range(50):
        shuffled = list(CRYPTOGRAPHY_WHEELS)
        random.Random(seed).shuffle(shuffled)
        assert picked_name(shuffled, platform_key) == expected


def test_reversed_listing_still_avoids_glibc_2_34_wheels():
    assert picked_name(list(reversed(CRYPTOGRAPHY_WHEELS)), ("linux", "intel")) == (
        "cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
    )


def test_wheel_needing_a_newer_python_is_rejected():
    only_future = ["cryptography-50.0.2-cp315-abi3.abi3t-macosx_11_0_arm64.whl"]
    assert picked_name(only_future, ("macos", "arm")) is None


def test_wheel_needing_a_newer_glibc_is_rejected():
    only_new_glibc = ["cryptography-50.0.2-cp39-abi3-manylinux_2_34_x86_64.whl"]
    assert picked_name(only_new_glibc, ("linux", "intel")) is None


def test_wheel_for_the_other_architecture_is_rejected():
    assert picked_name(["cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl"], ("macos", "intel")) is None


def test_prefers_a_cp313_wheel_over_an_abi3_wheel():
    names = [
        "pkg-1.0-cp311-abi3-macosx_11_0_arm64.whl",
        "pkg-1.0-cp313-cp313-macosx_11_0_arm64.whl",
    ]
    assert picked_name(names, ("macos", "arm")) == "pkg-1.0-cp313-cp313-macosx_11_0_arm64.whl"


def test_prefers_a_cp313_abi3_wheel_over_a_cp39_abi3_wheel():
    names = [
        "pkg-1.0-cp39-abi3-manylinux_2_17_x86_64.whl",
        "pkg-1.0-cp313-abi3-manylinux_2_17_x86_64.whl",
    ]
    assert picked_name(names, ("linux", "intel")) == "pkg-1.0-cp313-abi3-manylinux_2_17_x86_64.whl"


def test_prefers_manylinux_2_17_over_an_older_manylinux_tag():
    names = [
        "pkg-1.0-cp313-cp313-manylinux_2_12_x86_64.whl",
        "pkg-1.0-cp313-cp313-manylinux_2_17_x86_64.whl",
    ]
    assert picked_name(names, ("linux", "intel")) == "pkg-1.0-cp313-cp313-manylinux_2_17_x86_64.whl"


def test_accepts_an_older_manylinux_tag_when_it_is_the_only_one():
    names = ["pkg-1.0-cp313-cp313-manylinux_2_12_x86_64.whl"]
    assert picked_name(names, ("linux", "intel")) == "pkg-1.0-cp313-cp313-manylinux_2_12_x86_64.whl"


@pytest.mark.parametrize("platform_key", [("macos", "arm"), ("macos", "intel")])
def test_universal2_macos_wheel_serves_both_macos_architectures(platform_key):
    names = ["pkg-1.0-cp313-cp313-macosx_11_0_universal2.whl"]
    assert picked_name(names, platform_key) == "pkg-1.0-cp313-cp313-macosx_11_0_universal2.whl"


def test_macos_baseline_rejects_a_wheel_built_for_a_newer_macos():
    assert picked_name(["pkg-1.0-cp313-cp313-macosx_14_0_arm64.whl"], ("macos", "arm")) is None


def test_pure_wheel_is_found_by_tag_not_suffix():
    files = listing(["pkg-1.0-cp311-abi3-macosx_11_0_arm64.whl", "pkg-1.0-py3-none-any.whl"])
    assert gen.pure_wheel(files)["filename"] == "pkg-1.0-py3-none-any.whl"


@pytest.mark.parametrize("unusable", ["pkg-1.0-py2-none-any.whl", "pkg-1.0-cp38-none-any.whl"])
def test_pure_wheel_for_another_python_is_rejected(unusable):
    assert gen.pure_wheel(listing([unusable])) is None


def test_pure_wheel_prefers_the_more_specific_python_tag():
    files = listing(["pkg-1.0-py3-none-any.whl", "pkg-1.0-py313-none-any.whl"])
    assert gen.pure_wheel(files)["filename"] == "pkg-1.0-py313-none-any.whl"


def test_pure_wheel_is_the_same_for_every_listing_order():
    names = ["pkg-1.0-py3-none-any.whl", "pkg-1.0-py2.py3-none-any.whl", "pkg-1.0-py313-none-any.whl"]
    for seed in range(50):
        shuffled = list(names)
        random.Random(seed).shuffle(shuffled)
        assert gen.pure_wheel(listing(shuffled))["filename"] == "pkg-1.0-py313-none-any.whl"


def test_missing_platform_wheel_fails_loudly():
    files = listing(["cryptography-50.0.2-cp39-abi3-manylinux_2_34_x86_64.whl"])
    with pytest.raises(SystemExit) as raised:
        gen.require_wheel("cryptography", "50.0.2", files, ("linux", "intel"))
    assert str(raised.value) == "no cp313 wheel installable on linux/intel for cryptography 50.0.2"


def test_uv_resolver_targets_share_the_selector_glibc_baseline():
    assert gen.UV_PLATFORMS[("linux", "intel")] == "x86_64-manylinux_2_17"
    assert gen.UV_PLATFORMS[("linux", "arm")] == "aarch64-manylinux_2_17"


def test_python_version_is_spelled_once():
    assert gen.PYTHON_DOTTED == "3.13"
    assert gen.PYTHON_VERSION == (3, 13)
    assert gen.INTERPRETER == "cp313"


ALL_PLATFORM_CRYPTOGRAPHY = [
    "cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl",
    "cryptography-50.0.2-cp311-abi3-macosx_10_12_x86_64.whl",
    "cryptography-50.0.2-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl",
    "cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl",
]


def test_res_for_a_compiled_package_emits_a_block_per_platform_key():
    block = gen.res("cryptography", "50.0.2", listing(ALL_PLATFORM_CRYPTOGRAPHY), list(gen.PLATFORMS))
    base = "https://files.example/cryptography-50.0.2-cp311-abi3"
    expected = (
        '  resource "cryptography" do\n'
        "    on_macos do\n"
        "      on_arm do\n"
        f'        url "{base}-macosx_11_0_arm64.whl"\n'
        '        sha256 "sha-of-cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl"\n'
        "      end\n"
        "      on_intel do\n"
        f'        url "{base}-macosx_10_12_x86_64.whl"\n'
        '        sha256 "sha-of-cryptography-50.0.2-cp311-abi3-macosx_10_12_x86_64.whl"\n'
        "      end\n"
        "    end\n"
        "    on_linux do\n"
        "      on_arm do\n"
        f'        url "{base}-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"\n'
        '        sha256 "sha-of-cryptography-50.0.2-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"\n'
        "      end\n"
        "      on_intel do\n"
        f'        url "{base}-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"\n'
        '        sha256 "sha-of-cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"\n'
        "      end\n"
        "    end\n"
        "  end\n"
    )
    assert block == expected


def test_res_for_a_pure_package_emits_one_unconditional_url():
    block = gen.res("idna", "3.7", listing(["idna-3.7-py3-none-any.whl"]), list(gen.PLATFORMS))
    assert block == (
        '  resource "idna" do\n'
        '    url "https://files.example/idna-3.7-py3-none-any.whl"\n'
        '    sha256 "sha-of-idna-3.7-py3-none-any.whl"\n'
        "  end\n"
    )


def run_main(monkeypatch, capsys, files_by_name):
    monkeypatch.setattr(gen, "closure", lambda version: {name: "1.0" for name in files_by_name})
    monkeypatch.setattr(gen, "files_for", lambda name, version: listing(files_by_name[name]))
    gen.main("9.9.9")
    return capsys.readouterr().out


SKALDR_WHEEL = ["skaldr-9.9.9-py3-none-any.whl"]


def test_main_serves_every_platform_key_when_all_have_wheels(monkeypatch, capsys):
    out = run_main(
        monkeypatch,
        capsys,
        {"skaldr": SKALDR_WHEEL, "cryptography": ALL_PLATFORM_CRYPTOGRAPHY, "idna": ["idna-1.0-py3-none-any.whl"]},
    )
    assert re.findall(r"^\s+on_(arm|intel) do$", out, re.M) == ["arm", "intel", "arm", "intel"]
    assert "depends_on arch: :arm64" not in out
    assert 'depends_on "python@3.13"' in out
    assert 'system formula_opt_bin("python@3.13")/"python3.13"' in out


def test_main_drops_intel_macos_when_a_package_has_no_wheel_for_it(monkeypatch, capsys):
    out = run_main(
        monkeypatch,
        capsys,
        {"skaldr": SKALDR_WHEEL, "cryptography": CRYPTOGRAPHY_WHEELS, "idna": ["idna-1.0-py3-none-any.whl"]},
    )
    assert re.findall(r"^\s+on_(arm|intel) do$", out, re.M) == ["arm", "arm", "intel"]
    assert "  on_macos do\n    depends_on arch: :arm64\n  end\n" in out


def test_main_names_a_dependency_that_has_no_wheels(monkeypatch, capsys):
    with pytest.raises(SystemExit) as raised:
        run_main(monkeypatch, capsys, {"skaldr": SKALDR_WHEEL, "sdistonly": []})
    assert str(raised.value) == "sdistonly 1.0 has no wheels on PyPI; the formula installs wheels only"


def test_formula_test_imports_the_publish_extra(monkeypatch, capsys):
    out = run_main(monkeypatch, capsys, {"skaldr": SKALDR_WHEEL})
    assert '    system libexec/"bin/python", "-c", "import authlib, httpx2, keyring, cryptography"\n' in out
