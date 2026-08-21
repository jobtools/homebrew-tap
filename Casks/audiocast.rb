cask "audiocast" do
  version "1.1.72"
  sha256 "b03752224dcefe2b8927c6a948a4ccb1730f12cc282eafefd9ad82e3a0c1a1de"

  url "https://github.com/jobtools/homebrew-tap/releases/download/audiocast-v#{version}/AudioCast-#{version}.zip"
  name "AudioCast"
  desc "Stream macOS system audio to an Android phone over Wi-Fi"
  homepage "https://github.com/jobtools/homebrew-tap"

  depends_on macos: :sonoma

  app "AudioCast.app"

  uninstall quit: "com.audiocast.sender"

  caveats <<~CAVEATS
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
