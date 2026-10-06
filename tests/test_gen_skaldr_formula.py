import importlib.util
import itertools
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


def listing(filenames):
    return [{"filename": name, "url": f"https://files.example/{name}"} for name in filenames]


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
def test_choice_is_the_same_for_every_listing_order(platform_key):
    expected = picked_name(CRYPTOGRAPHY_WHEELS, platform_key)
    for ordering in itertools.islice(itertools.permutations(CRYPTOGRAPHY_WHEELS), 0, 5000, 37):
        assert picked_name(list(ordering), platform_key) == expected


def test_reversed_listing_still_avoids_glibc_2_34_wheels():
    reversed_listing = list(reversed(CRYPTOGRAPHY_WHEELS))
    assert picked_name(reversed_listing, ("linux", "intel")) == (
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


def test_macos_baseline_rejects_a_wheel_built_for_a_newer_macos():
    assert picked_name(["pkg-1.0-cp313-cp313-macosx_14_0_arm64.whl"], ("macos", "arm")) is None


def test_pure_wheel_is_found_by_tag_not_suffix():
    files = listing(["pkg-1.0-cp311-abi3-macosx_11_0_arm64.whl", "pkg-1.0-py3-none-any.whl"])
    assert gen.pure_wheel(files)["filename"] == "pkg-1.0-py3-none-any.whl"


def test_missing_platform_wheel_fails_loudly():
    files = listing(["cryptography-50.0.2-cp39-abi3-manylinux_2_34_x86_64.whl"])
    with pytest.raises(SystemExit) as raised:
        gen.require_wheel("cryptography", "50.0.2", files, ("linux", "intel"))
    assert str(raised.value) == "no cp313 wheel installable on linux/intel for cryptography 50.0.2"
