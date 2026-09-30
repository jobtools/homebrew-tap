class Gitpark < Formula
  desc "Park idle projects: drop what can be regenerated, prove nothing is lost first"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/releases/download/gitpark-v0.5.0/gitpark-0.5.0-darwin-universal.tar.gz"
  version "0.5.0"
  sha256 "eca921aa0e24609bcf6f087427c503c6230c251de2e283711ef0827a80b71dd0"
  depends_on :macos

  def install
    bin.install "gitpark"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitpark version")
  end
end
