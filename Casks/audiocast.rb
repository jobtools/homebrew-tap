cask "audiocast" do
  version "1.2.10"
  sha256 "71a8679c369139c011034c463696d65e6771c4a5599798e4c28ff11a8a30bc5c"

  url "https://github.com/jobtools/homebrew-tap/releases/download/audiocast-v#{version}/AudioCast-#{version}.dmg"
  name "AudioCast"
  desc "Stream macOS system audio to an Android phone over Wi-Fi"
  homepage "https://github.com/jobtools/homebrew-tap"

  depends_on macos: :sonoma

  app "AudioCast Sender.app"

  uninstall quit: "com.audiocast.sender"

  # Up to 1.2.3 the bundle was "AudioCast.app" — the same name the iPhone/iPad
  # receiver takes when it is installed on an Apple Silicon Mac from the App
  # Store, which is why it was renamed. Two leftovers from that era to clean up,
  # and one accident to undo.
  #
  # The accident: upgrading from a pre-rename cask runs the OLD cask's uninstall
  # first, and that copies whatever sits at "#{appdir}/AudioCast.app" into the
  # Caskroom and deletes the original — even when what sat there was the App
  # Store receiver, not us. Homebrew runs this preflight after that move and
  # before it purges the backup (Cask::Upgrade: start_upgrade → install_artifacts
  # → finalize_upgrade), so this is the one window where the receiver can be put
  # back. Nothing else on the machine can: the old cask is already on disk.
  preflight do
    legacy = Pathname("#{appdir}/AudioCast.app")

    # Ours only if it is a real macOS bundle carrying our sender's id. An App
    # Store iOS app has no Contents/ at all (it is a Wrapper/ bundle), so it
    # fails the first test and is never touched by mistake.
    ours = lambda do |path|
      plist = Pathname("#{path}/Contents/Info.plist")
      next false unless plist.exist?

      system_command("/usr/bin/defaults",
                     args:         ["read", "#{path}/Contents/Info", "CFBundleIdentifier"],
                     must_succeed: false).stdout.strip == "com.audiocast.sender"
    end

    # A hand-installed sender under the old name (direct .zip download) would
    # otherwise sit next to the new one, and the user would keep opening the
    # stale one.
    if legacy.exist? && ours.call(legacy)
      system_command "/bin/rm", args: ["-rf", legacy], must_succeed: false
    end

    # Put a displaced App Store receiver back where it belongs.
    Pathname.glob("#{staged_path.parent}/*/AudioCast.app").each do |backup|
      next if ours.call(backup)
      next if legacy.exist?

      opoo "Restoring the App Store AudioCast receiver that the previous version moved aside."
      system_command "/bin/mv", args: [backup, legacy], must_succeed: false
    end
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
