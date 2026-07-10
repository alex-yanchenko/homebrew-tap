# ccsearch has zero Python runtime dependencies, so this virtualenv install needs no
# `resource` stanzas — just the package itself. ripgrep and fzf are runtime binaries the
# tool shells out to, declared as formula dependencies below.
#
# url/sha256 point at the GitHub release sdist and are kept current by the tap's
# update-formulae workflow on each new release.
class Ccsearch < Formula
  include Language::Python::Virtualenv

  desc "Search your Claude Code sessions by content"
  homepage "https://github.com/alex-yanchenko/ccsearch"
  url "https://github.com/alex-yanchenko/ccsearch/releases/download/v0.2.0/ccsearch-0.2.0.tar.gz"
  sha256 "d4ae2222893adc2db226d49d072d952807df16662aa3e81ff5ced53541030615"
  license "PolyForm-Noncommercial-1.0.0"

  depends_on "fzf"
  depends_on "python@3.13"
  depends_on "ripgrep"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "search your Claude Code sessions", shell_output("#{bin}/ccsearch --help")
  end
end
