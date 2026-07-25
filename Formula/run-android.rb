class RunAndroid < Formula
  desc "Build, install and launch an Android Gradle project's APK on a device"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/archive/refs/tags/run-android-v1.0.0.tar.gz"
  sha256 "REPLACE_WITH_SHA256"
  license "MIT"

  def install
    bin.install "bin/run-android"
  end

  test do
    assert_match "run-android", shell_output("#{bin}/run-android --help")
  end
end
