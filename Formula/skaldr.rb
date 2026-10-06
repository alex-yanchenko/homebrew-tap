class Skaldr < Formula
  desc "Render a YAML content file into a self-contained HTML report page"
  homepage "https://github.com/alex-yanchenko/skaldr"
  url "https://files.pythonhosted.org/packages/ed/a4/0a30708dd0fb58bc745b1ba00645e7f638093af17eaab3c9dba57de6447c/skaldr-3.3.0-py3-none-any.whl"
  sha256 "304ab5b6492920baeaa888cc5adc99992596f030ebc80214272bacf2f1438249"
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
    url "https://files.pythonhosted.org/packages/12/b8/4bd346e22b28902df4d651910f5242c28d84e4a5c2435ca5c3f797ed7e2e/anyio-4.15.1-py3-none-any.whl"
    sha256 "6152fdbbf9a77fdec97731721bebf7c4c44f7c29b424b0065826173efc7ed101"
  end
  resource "authlib" do
    url "https://files.pythonhosted.org/packages/b8/c6/6f124bcfbbfb20fba22c939b4e43a06dccfc0e1ca20e5634ca573cb1e271/authlib-1.8.0-py2.py3-none-any.whl"
    sha256 "88aebbd9af6757e14e912d5dc007ae1dc1f3e27e3b2152ce7c552ee2c3b3c121"
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
  resource "h11" do
    url "https://files.pythonhosted.org/packages/04/4b/29cac41a4d98d144bf5f6d33995617b185d14b22401f75ca86f384e87ff1/h11-0.16.0-py3-none-any.whl"
    sha256 "63cf8bbe7522de3bf65932fda1d9c2772064ffb3dae62d55932da54b31cb6c86"
  end
  resource "httpcore2" do
    url "https://files.pythonhosted.org/packages/09/ba/a4568248771ce81957bfb7cc600264a40fbcda092391ee1c415c50be4bea/httpcore2-2.13.1-py3-none-any.whl"
    sha256 "e1e05d4f25f7d7d496bfb96748f6f4b67657b03da069b3a68c36069f3db73d0a"
  end
  resource "httpx2" do
    url "https://files.pythonhosted.org/packages/d8/9c/6fe8931fd9f381042a9e4c7d5a7b4cbf7016b252bec0c99a49fce42c3326/httpx2-2.13.1-py3-none-any.whl"
    sha256 "6dff50fabc270ee5fd25d845d0b078ed20564579744d6d962850975996d2f9a4"
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
    url "https://files.pythonhosted.org/packages/67/c5/82addfd375e5ee6520644e0553e4aadde92d668c4fc99cc716d337fe7bb3/joserfc-1.7.5-py3-none-any.whl"
    sha256 "add2c2c84e8373b084d526a8b53daba5d7a513a118cd2dcd9fc9f979d0922159"
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
    url "https://files.pythonhosted.org/packages/e8/3d/1087453384dbde46a8c7f9356eead2c58be8a7bf156bca40243377c85715/more_itertools-11.1.0-py3-none-any.whl"
    sha256 "4b65538ae22f6fed0ce4874efd317463a7489796a0939fa66824dd542125a192"
  end
  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/0c/c3/44f3fbbfa403ea2a7c779186dc20772604442dde72947e7d01069cbe98e3/pycparser-3.0-py3-none-any.whl"
    sha256 "b727414169a36b7d524c1c3e31839a521725078d7b2ff038656844266160a992"
  end
  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/eb/47/c95ffc2009878c7aac0c5e08528022dcb885933252a88b5f170058014464/pydantic-2.13.5-py3-none-any.whl"
    sha256 "346a034f080da3755d8e9cb5e00e8b07de1d39e4f6e2c87d8ab7cafa0b269a73"
  end
  resource "pydantic_core" do
    on_macos do
      on_arm do
        url "https://files.pythonhosted.org/packages/21/43/6323b1f8b217780454c61304bcd2b38ae4762f50754414124603ccc90bb2/pydantic_core-2.46.5-cp313-cp313-macosx_11_0_arm64.whl"
        sha256 "f332f0e72a5a0400141f830744e141bf9f97917878dbe968669e8a7fefea78ff"
      end
    end
    on_linux do
      on_arm do
        url "https://files.pythonhosted.org/packages/0f/a3/c05ca796e1197618a774b01e596aeedfefc2f7d8c01ae3054e910b120e8a/pydantic_core-2.46.5-cp313-cp313-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "193375f3548919d3f0b60936ca113ada3e38f264f91b9b8e0508efaad57be931"
      end
      on_intel do
        url "https://files.pythonhosted.org/packages/d3/f2/9e4de77a6271e07a76d2d58b11c091a979c191ed2939bf80067568b369d2/pydantic_core-2.46.5-cp313-cp313-manylinux_2_17_x86_64.manylinux2014_x86_64.whl"
        sha256 "6f7b393a8b3da82f5c1fc0751e6d01ac6c55b93c18226a60bdfba4a724efafd1"
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
  resource "tinycss2" do
    url "https://files.pythonhosted.org/packages/60/45/c7b5c3168458db837e8ceab06dc77824e18202679d0463f0e8f002143a97/tinycss2-1.5.1-py3-none-any.whl"
    sha256 "3415ba0f5839c062696996998176c4a3751d18b7edaaeeb658c9ce21ec150661"
  end
  resource "truststore" do
    url "https://files.pythonhosted.org/packages/19/97/56608b2249fe206a67cd573bc93cd9896e1efb9e98bce9c163bcdc704b88/truststore-0.10.4-py3-none-any.whl"
    sha256 "adaeaecf1cbb5f4de3b1959b42d41f6fab57b2b1666adb59e89cb0b53361d981"
  end
  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/49/d3/b8441a820a491ddfc024b0b0cf0393375b75ea13866d9c66727e54c2fc80/typing_extensions-4.16.0-py3-none-any.whl"
    sha256 "481caa481374e813c1b176ada14e97f1f67a4539ce9cfeb3f350d78d6370c2e8"
  end
  resource "typing_inspection" do
    url "https://files.pythonhosted.org/packages/67/81/4add07e5172b7ac40d8ed5ff580409a7801a4fe26d529bdd915401dabfbe/typing_inspection-0.4.4-py3-none-any.whl"
    sha256 "65b8397ba37ccbce054456aaccddfc91e6e3083c92824df348d96ca832f3f147"
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
