# ccfind has zero Python runtime dependencies, so this virtualenv install needs no
# `resource` stanzas — just the package itself. ripgrep and fzf are runtime binaries the
# tool shells out to, declared as formula dependencies below.
#
# url/sha256 point at the GitHub release sdist and are kept current by the tap's
# update-formulae workflow. Until ccfind's first release (v0.1.0) exists the sha256 is a
# placeholder and `brew install` will fail the checksum — this formula goes live with
# that release.
class Ccfind < Formula
  include Language::Python::Virtualenv

  desc "Search your Claude Code sessions by content"
  homepage "https://github.com/alex-yanchenko/ccfind"
  url "https://github.com/alex-yanchenko/ccfind/releases/download/v0.1.0/ccfind-0.1.0.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "PolyForm-Noncommercial-1.0.0"

  depends_on "fzf"
  depends_on "python@3.13"
  depends_on "ripgrep"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "search your Claude Code sessions", shell_output("#{bin}/ccfind --help")
  end
end
