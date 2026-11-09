class Skaldr < Formula
  desc "Render a YAML content file into a self-contained HTML report page"
  homepage "https://github.com/alex-yanchenko/skaldr"
  url "https://files.pythonhosted.org/packages/35/8d/fc02dd209cdfc897c05adba64665b6a6de2b6c41dce1ce0f50c8706cface/skaldr-4.3.0-py3-none-any.whl"
  sha256 "c038111c436071537a8c81c7bc2c914ccaec76ff7a03a1b73fb792db9569ad96"
  license "MIT"

  depends_on "libyaml"
  depends_on "python@3.13"

  on_macos do
    depends_on arch: :arm64
  end

  resource "annotated_types" do
    url "https://files.pythonhosted.org/packages/99/91/8acff4f5e50511b911bbccb72b8628a49c68ce14148cd9f6431094859a90/annotated_types-0.8.0-py3-none-any.whl"
    sha256 "f072f4d804ea359e4eaf198b1af7a8b0943881a87f31bb764f8bf219bb9419e0"
  end
  resource "anyio" do
    url "https://files.pythonhosted.org/packages/a9/16/7757fb84c819accc7d7e9af5291b261e4abb8627ee040f99e7d35ef2457a/anyio-4.16.0-py3-none-any.whl"
    sha256 "c66ae634e0b8228396b801741beb3294326d4b6102f7bba4041c0dfb58c29026"
  end
  resource "authlib" do
    url "https://files.pythonhosted.org/packages/58/d7/d384e7a639dd1d018767ba0fe39601b61cded066bb7af38db31ec998252d/authlib-1.9.5-py2.py3-none-any.whl"
    sha256 "e32a63e3d869196b61816b2602231862179a2ffc29358c009d1f022c8b86a8b2"
  end
  resource "cffi" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/55/41/4c7042f317b9217502988f0873af87e16ad606dc20f84e546e3e6ce9764c/cffi-2.1.1-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "19ee6127ee34de7d83ce3d371ebc5ed91addbdcc39f9ab15ce4eb35a4e534971"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/37/6f/3b5ce4c3b2192d250f04908f2bfd91ef34552ec8f7716a5d4abdb8d67bb2/cffi-2.1.1-cp313-cp313-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "f16c709686a78c727bbbf059f92b0bf41c6fc60deec706d2dc19f529175a6125"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/95/95/86342356ff5953b3fb06f7ef7c5bee212d45e770abc7218d451b9148313c/cffi-2.1.1-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "a931079504ecc49efed7744c476a5c343a92fabf66dec2db95edb1b2fdc770e2"
      end
    end
  end
  resource "cryptography" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/e5/56/d194340cc4a57535e82e1bee9e89667ac4b7c13b5d3f59686deae3094dd5/cryptography-50.0.2-cp311-abi3-macosx_11_0_arm64.whl"
        sha256 "fa8f5efb344d6908a1ce62f4a24e2e5780f825d6f53f5f50ec5ffacac72936cb"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/d9/69/c9bd862c3bf43d6399c433caf002df16e2dffd4be49bdf515cda38038711/cryptography-50.0.2-cp311-abi3-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "79def8d059362e7831389ed3be0ecdf58a89386e1271e35dd9f5af84e81bffd0"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/21/69/64cef1f702bf6657e0cc186ed1a2891d50d29fb41586b254e1c07adea261/cryptography-50.0.2-cp311-abi3-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "630ebfea3bf689d075f82316324ff7433dc447fe6bc1bfc76524b74b4a9567d2"
      end
    end
  end
  resource "emoji" do
    url "https://files.pythonhosted.org/packages/fd/8a/75e3177f374877b19dd3112820b071836ad1100f9f58424630b4783519bc/emoji-2.16.0-py3-none-any.whl"
    sha256 "c4230d80640def9071599ff56b1b5950fe13a2a94c0da98c5deab12431b24330"
  end
  resource "filelock" do
    url "https://files.pythonhosted.org/packages/00/05/76184fe08339723d643ab47887a8e4de8f2921ca4e008617ab7490af7857/filelock-4.2.9-py3-none-any.whl"
    sha256 "a379c50a729e5b68c8519a4d26489f755d9769960a236ecd838190e2a78db2e9"
  end
  resource "h11" do
    url "https://files.pythonhosted.org/packages/04/4b/29cac41a4d98d144bf5f6d33995617b185d14b22401f75ca86f384e87ff1/h11-0.16.0-py3-none-any.whl"
    sha256 "63cf8bbe7522de3bf65932fda1d9c2772064ffb3dae62d55932da54b31cb6c86"
  end
  resource "httpcore2" do
    url "https://files.pythonhosted.org/packages/af/c2/ce417c397afa5181f0e3c6ff01a4d01639414e1adef08730d97571297151/httpcore2-2.16.0-py3-none-any.whl"
    sha256 "5c4358319f2602d984ad93182c9fee5160f22e9da7babdda870a5e7c4e2dc34f"
  end
  resource "httpx2" do
    url "https://files.pythonhosted.org/packages/7b/3d/2e4bc4fd1ef9770871669adb348d612a6e4786b303a23f9935b81c48dd60/httpx2-2.16.0-py3-none-any.whl"
    sha256 "fd2c5d7909e8d86fe92d53020c310ca0e4e431b838c207c5754b9bbf0308d49a"
  end
  resource "idna" do
    url "https://files.pythonhosted.org/packages/58/a2/bb081bab032533a855d44de1d56f8e8426114ff1ba5d1f07a438a0a654f8/idna-3.20-py3-none-any.whl"
    sha256 "ab7ae7122974553370f0bdb919e1a960b2cd1bc1ef0276416d896db81c14582c"
  end
  resource "jaraco_classes" do
    url "https://files.pythonhosted.org/packages/7f/66/b15ce62552d84bbfcec9a4873ab79d993a1dd4edb922cbfccae192bd5b5f/jaraco.classes-3.4.0-py3-none-any.whl"
    sha256 "f662826b6bed8cace05e7ff873ce0f9283b5c924470fe664fff1c2f00f581790"
  end
  resource "jaraco_context" do
    url "https://files.pythonhosted.org/packages/f2/58/bc8954bda5fcda97bd7c19be11b85f91973d67a706ed4a3aec33e7de22db/jaraco_context-6.1.2-py3-none-any.whl"
    sha256 "bf8150b79a2d5d91ae48629d8b427a8f7ba0e1097dd6202a9059f29a36379535"
  end
  resource "jaraco_functools" do
    url "https://files.pythonhosted.org/packages/02/36/ecc85bc96c273dc8a11273ed4782272975e6338d4a3e9228621175edf0e3/jaraco_functools-4.6.0-py3-none-any.whl"
    sha256 "99e3dc0060c5cbe8fcd1cdb36258e2a65ca40f1566b2033b12abb1bb44dd3c30"
  end
  resource "jeepney" do
    url "https://files.pythonhosted.org/packages/b2/a3/e137168c9c44d18eff0376253da9f1e9234d0239e0ee230d2fee6cea8e55/jeepney-0.9.0-py3-none-any.whl"
    sha256 "97e5714520c16fc0a45695e5365a2e11b81ea79bba796e26f9f1d178cb182683"
  end
  resource "jinja2" do
    url "https://files.pythonhosted.org/packages/62/a1/3d680cbfd5f4b8f15abc1d571870c5fc3e594bb582bc3b64ea099db13e56/jinja2-3.1.6-py3-none-any.whl"
    sha256 "85ece4451f492d0c13c5dd7c13a64681a86afae63a5f347908daf103ce6d2f67"
  end
  resource "joserfc" do
    url "https://files.pythonhosted.org/packages/5e/7e/7ffaae13415e8f51c8e8d5d1845f2de7a27ebf2717e97a38d7e7446d6030/joserfc-1.8.0-py3-none-any.whl"
    sha256 "176b836ac7ed9a46a88629e24076314b475f33a75d0bad7f26146e572eed7c79"
  end
  resource "keyring" do
    url "https://files.pythonhosted.org/packages/81/db/e655086b7f3a705df045bf0933bdd9c2f79bb3c97bfef1384598bb79a217/keyring-25.7.0-py3-none-any.whl"
    sha256 "be4a0b195f149690c166e850609a477c532ddbfbaed96a404d4e43f8d5e2689f"
  end
  resource "latex2mathml" do
    url "https://files.pythonhosted.org/packages/07/30/b8bcfb01a2514cb7554a048ed52883de276e66d757c3cc535a3c29eb9e98/latex2mathml-3.81.1-py3-none-any.whl"
    sha256 "c337668441b71c819b6733905a8058ba9a9d767bae11a0c5fdacb3aff31361bd"
  end
  resource "markdown_it_py" do
    url "https://files.pythonhosted.org/packages/b3/81/4da04ced5a082363ecfa159c010d200ecbd959ae410c10c0264a38cac0f5/markdown_it_py-4.2.0-py3-none-any.whl"
    sha256 "9f7ebbcd14fe59494226453aed97c1070d83f8d24b6fc3a3bcf9a38092641c4a"
  end
  resource "markupsafe" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/ca/e0/4030bea613677e333c8a2c901fd405055f657f9d06acba5b7357984b6ef7/markupsafe-3.0.4-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "73e77980c7207854f00fc4e71fb1626868d5740ab4012623d55c7a99ad122a72"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/f3/a5/28b76a7449eb702966b88bef599e2360b411fbb3afeee8fe560939be06ec/markupsafe-3.0.4-cp313-cp313-manylinux2014_aarch64.manylinux_2_17_aarch64.manylinux_2_28_aarch64.whl"
        sha256 "7018d4af1cd272e847aa5917983ab5e83e4f6579f9dbfecd4a79c0ca80b144c2"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/63/e0/cec6865dfe88cb48fedd4b20aed6af5158e41092adcbf3e028bcc6ec2108/markupsafe-3.0.4-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.manylinux_2_28_x86_64.whl"
        sha256 "434139499bb20b502ed3baa1f169e618f924a97e7a777fea1a49446d80106cf6"
      end
    end
  end
  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/b3/38/89ba8ad64ae25be8de66a6d463314cf1eb366222074cfda9ee839c56a4b4/mdurl-0.1.2-py3-none-any.whl"
    sha256 "84008a41e51615a49fc9966191ff91509e3c40b939176e643fd50a5c2196b8f8"
  end
  resource "more_itertools" do
    url "https://files.pythonhosted.org/packages/5d/57/3c4b1c6f2e0cc29ba023802458ea3d2a996f87085559e4a5f2192d549532/more_itertools-11.2.1-py3-none-any.whl"
    sha256 "35a7377edd1dd6608dcb2cdf534ded55ea32d49448875ad042cd3f879fb1ded0"
  end
  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/b6/ae/315bbeee126a769cbde43cf4908acb4b40408d8bf8bbf334dd7368d8dadf/pycparser-3.12-py3-none-any.whl"
    sha256 "a076f3f489b39b43ed13563a1dafe42447445bec2e294154ec5c57fcdda4c85e"
  end
  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/72/b8/b864503789ef5c58597d2a7b4adbee62c26440ab1e682581fc6838df8947/pydantic-2.14.3-py3-none-any.whl"
    sha256 "3f7b347782ab7e4cf4c798496ae3a82787d9f21ec12676a9c564355eeef8daa8"
  end
  resource "pydantic_core" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/90/a9/fc89a632331882c4cb91b949003418e6f5085ddcf2c9b875d499682bca91/pydantic_core-2.50.4-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "1239daaf063e62213ca1f34d96663900bd7510c42a786e843fd328af70e46445"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/b3/b8/936cb0d85a4082e902c7397db0f05c4372eac08372c8bd2d0b43088fcf17/pydantic_core-2.50.4-cp313-cp313-manylinux2014_aarch64.manylinux_2_17_aarch64.whl"
        sha256 "a9ee990bf2cfbd81574c5d4f9f6c9d480a14b5b43d2c4f2ca13f4c6f48089394"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/2b/c0/1c8f2c8f1b03d3fe2fdd7962df8f5a744fe48c90b4c49615e4eb77d04141/pydantic_core-2.50.4-cp313-cp313-manylinux2014_x86_64.manylinux_2_17_x86_64.whl"
        sha256 "fb2bb5b557080da398b866408117d98fe9731a12334afd0cdff221b458cdc5dc"
      end
    end
  end
  resource "pygments" do
    url "https://files.pythonhosted.org/packages/71/46/17f022dd3e953bf20a04a028a21ec746d942f8d2af30fa0f124fa0e6a684/pygments-2.21.0-py3-none-any.whl"
    sha256 "2363c69b61c4a97c838da3b130dcd6468f4848992b21a82f2a63ec34377137d9"
  end
  resource "pyyaml" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/b1/16/95309993f1d3748cd644e02e38b75d50cbc0d9561d21f390a76242ce073f/pyyaml-6.0.3-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "2283a07e2c21a2aa78d9c4442724ec1eb15f5e42a723b99cb3d822d48f5f7ad1"
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
  resource "roman" do
    url "https://files.pythonhosted.org/packages/10/14/ea3cdd7276fcd731a9003fe4abeb6b395a38110ddff6a6a509f4ee00f741/roman-5.2-py3-none-any.whl"
    sha256 "89d3b47400388806d06ff77ea77c79ab080bc127820dea6bf34e1f1c1b8e676e"
  end
  resource "secretstorage" do
    url "https://files.pythonhosted.org/packages/b7/46/f5af3402b579fd5e11573ce652019a67074317e18c1935cc0b4ba9b35552/secretstorage-3.5.0-py3-none-any.whl"
    sha256 "0ce65888c0725fcb2c5bc0fdb8e5438eece02c523557ea40ce0703c266248137"
  end
  resource "tenacity" do
    url "https://files.pythonhosted.org/packages/d6/26/1ff2b0721ac66a3ec5b1402b333110b352ab0a8724052ac279a7b82d40c4/tenacity-9.2.1-py3-none-any.whl"
    sha256 "9e56f17539296baab7beabb08b92f6ee3d7be92d8be72d763360677c2ad6580e"
  end
  resource "tinycss2" do
    url "https://files.pythonhosted.org/packages/60/45/c7b5c3168458db837e8ceab06dc77824e18202679d0463f0e8f002143a97/tinycss2-1.5.1-py3-none-any.whl"
    sha256 "3415ba0f5839c062696996998176c4a3751d18b7edaaeeb658c9ce21ec150661"
  end
  resource "truststore" do
    url "https://files.pythonhosted.org/packages/51/e9/3a7820be2bb0fe53b6bc9c3be26d3d1158004e4c3ab953aa6840b955b1e9/truststore-0.10.5-py3-none-any.whl"
    sha256 "9aaaedaefaf06d8b206278cf8b5012bc897f485a874503501e12d776df78951c"
  end
  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl"
    sha256 "481caa481374e813c1b176ada14e97f1f67a4539ce9cfeb3f350d78d6370c2e8"
  end
  resource "typing_inspection" do
    url "https://files.pythonhosted.org/packages/de/0c/ea2544850a7c135e15033a5c7a8e7211136184b7ae63e2239d557c2b3019/typing_inspection-0.4.5-py3-none-any.whl"
    sha256 "bc210535442b39e1bf2805e0c7a17dfd6a4ace760c84c7f7d16245d23a6b1c39"
  end
  resource "webencodings" do
    url "https://files.pythonhosted.org/packages/77/c6/040cbc72480d789a5f40d63fb484d3106554c4dfa2d2b70ad5022057750f/webencodings-0.6.1-py3-none-any.whl"
    sha256 "7fab6269c8bf237c657876b52058ccb182e861518d1c695c1a9aaa8c1c105d5b"
  end

  def install
    system formula_opt_bin("python@3.13")/"python3.13", "-m", "venv", libexec
    wheelhouse = buildpath/"wheelhouse"
    wheelhouse.mkpath
    # .whl is not an archive Homebrew unpacks, so cached_download / the staged file IS the
    # wheel. Collect skaldr + every pinned dependency wheel, then install offline.
    cp cached_download, wheelhouse/"skaldr-#{version}-py3-none-any.whl"
    resources.each { |r| r.stage { cp Dir["*.whl"].first, wheelhouse } }
    system libexec/"bin/pip", "install", "--no-index", "--find-links", wheelhouse, "skaldr[publish]==#{version}"
    bin.install_symlink libexec/"bin/skaldr"
  end

  test do
    system bin/"skaldr", "--help"
    system libexec/"bin/python", "-c", "import authlib, httpx2, keyring, cryptography"
  end
end
