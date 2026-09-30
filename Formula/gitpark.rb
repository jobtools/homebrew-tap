class Gitpark < Formula
  desc "Park idle projects: drop what can be regenerated, prove nothing is lost first"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/releases/download/gitpark-v0.1.0/gitpark-0.1.0-darwin-universal.tar.gz"
  version "0.1.0"
  sha256 "833e0da979502f45f75a97913028c6e1ef11bbd4aed9f49a71a6e270bb9e57e1"
  depends_on :macos

  def install
    bin.install "gitpark"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitpark version")
  end
end
