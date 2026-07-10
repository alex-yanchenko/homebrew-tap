# ccsearch is a zero-dependency, pure-Python (py3-none-any) wheel, so we install the
# prebuilt wheel straight from the release — nothing is compiled or resolved at install
# time. (Homebrew's virtualenv_install_with_resources forces --no-binary source builds,
# which can't build ccsearch's uv_build backend; installing the prebuilt wheel avoids that.)
#
# url/sha256 point at the release wheel and are kept current by the tap's update-formulae
# workflow on each new release.
class Ccsearch < Formula
  include Language::Python::Virtualenv

  desc "Search your Claude Code sessions by content"
  homepage "https://github.com/alex-yanchenko/ccsearch"
  url "https://github.com/alex-yanchenko/ccsearch/releases/download/v0.2.2/ccsearch-0.2.2-py3-none-any.whl"
  sha256 "cd3e0950bd75b2a84eb7bf26966eaead3b9d4609b65227ef879afe7eaccc9778"
  license "PolyForm-Noncommercial-1.0.0"

  depends_on "fzf"
  depends_on "python@3.13"
  depends_on "ripgrep"

  def install
    # Plain `venv` (not Homebrew's virtualenv_create, which builds --without-pip) so the
    # venv has pip to unpack the wheel with. cached_download is the prebuilt wheel; copy it
    # to a valid wheel filename and install it (--no-deps: there are none; --no-index:
    # never touch the network in the Homebrew build sandbox).
    system formula_opt_bin("python@3.13")/"python3.13", "-m", "venv", libexec
    whl = buildpath/"ccsearch-#{version}-py3-none-any.whl"
    cp cached_download, whl
    system libexec/"bin/pip", "install", "--no-deps", "--no-index", "--no-cache-dir", whl
    bin.install_symlink libexec/"bin/ccsearch"
  end

  test do
    assert_match "search your Claude Code sessions", shell_output("#{bin}/ccsearch --help")
  end
end
