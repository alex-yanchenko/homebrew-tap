class Skaldr < Formula
  desc "Render a YAML content file into a self-contained HTML report page"
  homepage "https://github.com/alex-yanchenko/skaldr"
  url "https://files.pythonhosted.org/packages/9d/95/0daf0ba45c7cd43900aecf0cb26daf4cdbcb5689b430a752cff6b3913373/skaldr-0.3.0-py3-none-any.whl"
  sha256 "9b816a60c4033d186275a0f324637ed82a645b32701500b20968b56a7bfa1624"
  license "MIT"

  depends_on "libyaml"
  depends_on "python@3.13"

  resource "annotated_types" do
    url "https://files.pythonhosted.org/packages/78/b6/6307fbef88d9b5ee7421e68d78a9f162e0da4900bc5f5793f6d3d0e34fb8/annotated_types-0.7.0-py3-none-any.whl"
    sha256 "1f02e8b43a8fbbc3f3e0d4f0f4bfc8131bcb4eebe8849b8e5c773f3a1c582a53"
  end
  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/62/a1/3d680cbfd5f4b8f15abc1d571870c5fc3e594bb582bc3b64ea099db13e56/jinja2-3.1.6-py3-none-any.whl"
    sha256 "85ece4451f492d0c13c5dd7c13a64681a86afae63a5f347908daf103ce6d2f67"
  end
  resource "markupsafe" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/9c/d9/5f7756922cdd676869eca1c4e3c0cd0df60ed30199ffd775e319089cb3ed/markupsafe-3.0.3-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "116bb52f642a37c115f517494ea5feb03889e04df47eeff5b130b1808ce7c219"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/38/2f/907b9c7bbba283e68f20259574b13d005c121a0fa4c175f9bed27c4597ff/markupsafe-3.0.3-cp313-cp313-macosx_10_13_x86_64.whl"
        sha256 "e1cf1972137e83c5d4c136c43ced9ac51d0e124706ee1c8aa8532c1287fa8795"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/00/07/575a68c754943058c78f30db02ee03a64b3c638586fba6a6dd56830b30a3/markupsafe-3.0.3-cp313-cp313-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "133a43e73a802c5562be9bbcd03d090aa5a1fe899db609c29e8c8d815c5f6de6"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/a9/21/9b05698b46f218fc0e118e1f8168395c65c8a2c750ae2bab54fc4bd4e0e8/markupsafe-3.0.3-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "ccfcd093f13f0f0b7fdd0f198b90053bf7b2f02a3927a30e63f3ccc9df56b676"
      end
    end
  end
  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/fd/7b/122376b1fd3c62c1ed9dc80c931ace4844b3c55407b6fb2d199377c9736f/pydantic-2.13.4-py3-none-any.whl"
    sha256 "45a282cde31d808236fd7ea9d919b128653c8b38b393d1c4ab335c62924d9aba"
  end
  resource "pydantic_core" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/c1/81/4fa520eaffa8bd7d1525e644cd6d39e7d60b1592bc5b516693c7340b50f1/pydantic_core-2.46.4-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "c94f0688e7b8d0a67abf40e57a7eaaecd17cc9586706a31b76c031f63df052b4"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/51/a2/5d30b469c5267a17b39dec53208222f76a8d351dfac4af661888c5aee77d/pydantic_core-2.46.4-cp313-cp313-macosx_10_12_x86_64.whl"
        sha256 "5d5902252db0d3cedf8d4a1bc68f70eeb430f7e4c7104c8c476753519b423008"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/03/d5/fd02da45b659668b05923b17ba3a0100a0a3d5541e3bd8fcc4ecb711309e/pydantic_core-2.46.4-cp313-cp313-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "f027324c56cd5406ca49c124b0db10e56c69064fec039acc571c29020cc87c76"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/07/f8/41db9de19d7987d6b04715a02b3b40aea467000275d9d758ffaa31af7d50/pydantic_core-2.46.4-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "9551187363ffc0de2a00b2e47c25aeaeb1020b69b668762966df15fc5659dd5a"
      end
    end
  end
  resource "pyyaml" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/b1/16/95309993f1d3748cd644e02e38b75d50cbc0d9561d21f390a76242ce073f/pyyaml-6.0.3-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "2283a07e2c21a2aa78d9c4442724ec1eb15f5e42a723b99cb3d822d48f5f7ad1"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/d1/11/0fd08f8192109f7169db964b5707a2f1e8b745d4e239b784a5a1dd80d1db/pyyaml-6.0.3-cp313-cp313-macosx_10_13_x86_64.whl"
        sha256 "8da9669d359f02c0b91ccc01cac4a67f16afec0dac22c2ad09f46bee0697eba8"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/50/31/b20f376d3f810b9b2371e72ef5adb33879b25edb7a6d072cb7ca0c486398/pyyaml-6.0.3-cp313-cp313-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "ee2922902c45ae8ccada2c5b501ab86c36525b883eff4255313a253a3160861c"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/74/27/e5b8f34d02d9995b80abcef563ea1f8b56d20134d8f4e5e81733b1feceb2/pyyaml-6.0.3-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "0f29edc409a6392443abf94b9cf89ce99889a1dd5376d94316ae5145dfedd5d6"
      end
    end
  end
  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl"
    sha256 "481caa481374e813c1b176ada14e97f1f67a4539ce9cfeb3f350d78d6370c2e8"
  end
  resource "typing_inspection" do
    url "https://files.pythonhosted.org/packages/dc/9b/47798a6c91d8bdb567fe2698fe81e0c6b7cb7ef4d13da4114b41d239f65d/typing_inspection-0.4.2-py3-none-any.whl"
    sha256 "4ed1cacbdc298c220f1bd249ed5287caa16f34d44ef4e9c3d0cbad5b521545e7"
  end

  def install
    system formula_opt_bin("python@3.13")/"python3.13", "-m", "venv", libexec
    wheelhouse = buildpath/"wheelhouse"
    wheelhouse.mkpath
    # .whl is not an archive Homebrew unpacks, so cached_download / the staged file IS the
    # wheel. Collect skaldr + every pinned dependency wheel, then install offline.
    cp cached_download, wheelhouse/"skaldr-#{version}-py3-none-any.whl"
    resources.each { |r| r.stage { cp Dir["*.whl"].first, wheelhouse } }
    system libexec/"bin/pip", "install", "--no-index", "--find-links", wheelhouse, "skaldr==#{version}"
    bin.install_symlink libexec/"bin/skaldr"
  end

  test do
    system bin/"skaldr", "--help"
  end
end
