cask "audiocast" do
  version "1.1.71"
  sha256 "3ff88dfc76f449aa6b5364e2ea363029056e9a1d6fb55f01fd7d996dfba97120"

  url "https://github.com/jobtools/homebrew-tap/releases/download/audiocast-v#{version}/AudioCast-#{version}.zip"
  name "AudioCast"
  desc "Stream macOS system audio to an Android phone over Wi-Fi"
  homepage "https://github.com/jobtools/homebrew-tap"

  depends_on macos: :sonoma

  app "AudioCast.app"

  uninstall quit: "com.audiocast.sender"

  caveats <<~CAVEATS
    Upgrading from an older, self-signed build: this release is signed
    with a new (Apple-notarized) certificate, so macOS no longer matches
    it to the permissions you already granted. Microphone access is
    re-requested automatically, and AudioCast clears the stale
    Accessibility entry on first launch so it can ask for it again.

    If media keys or "pause on disconnect" still do nothing, reset the
    entry by hand and reopen the app:

        tccutil reset Accessibility com.audiocast.sender

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
