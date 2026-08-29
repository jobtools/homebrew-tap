cask "audiocast" do
  version "1.2.4"
  sha256 "960d3d2da6f7909ce54b0cfeb22bea87996077be351be3ae184da12d2dbda2e6"

  url "https://github.com/jobtools/homebrew-tap/releases/download/audiocast-v#{version}/AudioCast-#{version}.zip"
  name "AudioCast"
  desc "Stream macOS system audio to an Android phone over Wi-Fi"
  homepage "https://github.com/jobtools/homebrew-tap"

  depends_on macos: :sonoma

  app "AudioCast Sender.app"

  uninstall quit: "com.audiocast.sender"

  # Up to 1.2.3 the bundle was "AudioCast.app". An upgrade removes that one on
  # its own (brew uninstalls the old artifact first), but a hand-installed copy
  # from the direct download would linger next to the new name. Trash it — and
  # only it: on an Apple Silicon Mac the same path can hold the iOS receiver
  # installed from the App Store, which is exactly the collision this rename
  # exists to end, so check the bundle id before deleting anything.
  preflight do
    legacy = "#{appdir}/AudioCast.app"
    plist = "#{legacy}/Contents/Info.plist"
    next unless File.exist?(plist)

    id = system_command("/usr/bin/defaults",
                        args: ["read", "#{legacy}/Contents/Info", "CFBundleIdentifier"],
                        must_succeed: false).stdout.strip
    next unless id == "com.audiocast.sender"

    system_command "/bin/rm", args: ["-rf", legacy], sudo: false, must_succeed: false
  end

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
