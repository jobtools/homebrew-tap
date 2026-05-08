cask "audiocast" do
  version "1.1.22"
  sha256 "31b34e05424cb146f2f4e30d18d0066805463836f03b2cb66078f993df4815be"

  url "https://github.com/jobtools/homebrew-tap/releases/download/audiocast-v#{version}/AudioCast-#{version}.zip"
  name "AudioCast"
  desc "Stream macOS system audio to an Android phone over Wi-Fi"
  homepage "https://github.com/jobtools/homebrew-tap"

  depends_on macos: ">= :sonoma"
  depends_on formula: "opus"

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
    device). On first connect the app downloads and installs the driver
    via the standard macOS admin prompt. After install, open the menu bar
    icon and click "Connect" once a phone shows up.
  CAVEATS

  zap trash: [
    "~/Library/Application Support/AudioCast",
    "~/Library/Preferences/com.audiocast.sender.plist",
  ]
end
