class Gitpark < Formula
  desc "Park idle projects: drop what can be regenerated, prove nothing is lost first"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/releases/download/gitpark-v0.3.0/gitpark-0.3.0-darwin-universal.tar.gz"
  version "0.3.0"
  sha256 "11d6666e3e5f28b6e5fb0e14dbb67765a50daa884a8caf1cf2dc89fd8f65e732"
  depends_on :macos

  def install
    bin.install "gitpark"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gitpark version")
  end
end
