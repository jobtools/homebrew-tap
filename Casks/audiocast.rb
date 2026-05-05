cask "audiocast" do
  version "0.1.12"
  sha256 "27221de704878e1907f2ab491633c7d8dd7071a1c30a4bfb55170b8f96a946ca"

  url "https://github.com/jobtools/homebrew-audiocast/releases/download/mac-v#{version}/AudioCast-mac-v#{version}.zip"
  name "AudioCast"
  desc "Stream macOS system audio to an Android phone over Wi-Fi"
  homepage "https://github.com/jobtools/homebrew-audiocast"

  depends_on macos: ">= :sonoma"
  depends_on formula: "opus"
  depends_on cask: "audiocast-driver"

  app "AudioCast.app"

  uninstall quit: "com.audiocast.sender"

  postflight do
    # Strip the quarantine attribute so Sequoia does not refuse first launch.
    [
      "#{staged_path}/AudioCast.app",
      "#{appdir}/AudioCast.app",
    ].each do |path|
      system_command "/usr/bin/xattr",
                     args: ["-dr", "com.apple.quarantine", path],
                     must_succeed: false
    end
  end

  caveats <<~CAVEATS
    AudioCast is self-signed (not Apple-notarized).

    Quarantine is removed automatically on install. If macOS still refuses
    to open the app, allow it via System Settings → Privacy & Security →
    "Open Anyway" once.

    AudioCast streams audio through the AudioCast Driver (a virtual audio
    device installed automatically as a cask dependency). After install,
    open the menu bar icon and click "Connect" once a phone shows up.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AudioCast",
    "~/Library/Preferences/com.audiocast.sender.plist",
  ]
end
