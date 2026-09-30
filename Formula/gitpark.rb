class Gitpark < Formula
  desc "Park idle projects: drop what can be regenerated, prove nothing is lost first"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/releases/download/gitpark-v0.2.0/gitpark-0.2.0-darwin-universal.tar.gz"
  version "0.2.0"
  sha256 "329c70437219bdaa77153238283599936bfd4d63784e04079232b88d98bed6f9"
  depends_on :macos

  def install
    bin.install "gitpark"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitpark version")
  end
end
