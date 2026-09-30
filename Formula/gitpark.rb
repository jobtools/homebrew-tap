class Gitpark < Formula
  desc "Park idle projects: drop what can be regenerated, prove nothing is lost first"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/releases/download/gitpark-v0.4.0/gitpark-0.4.0-darwin-universal.tar.gz"
  version "0.4.0"
  sha256 "9e8fb953fa0f431fc539df924f04ec36c1f6a33420bdfd9f36f16e0d31aad9df"
  depends_on :macos

  def install
    bin.install "gitpark"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitpark version")
  end
end
