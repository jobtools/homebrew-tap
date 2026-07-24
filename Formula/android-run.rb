class AndroidRun < Formula
  desc "Build, install and launch an Android Gradle project's APK on a device"
  homepage "https://github.com/jobtools/homebrew-tap"
  url "https://github.com/jobtools/homebrew-tap/archive/refs/tags/android-run-v1.0.0.tar.gz"
  sha256 "14248247194f65c1399ca167819253702d3d52975586badcc39b51de0e35e155"
  license "MIT"

  def install
    bin.install "bin/android-run"
  end

  test do
    assert_match "android-run", shell_output("#{bin}/android-run --help")
  end
end
