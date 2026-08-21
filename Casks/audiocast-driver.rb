cask "audiocast-driver" do
  version "1.1.12"
  sha256 "a7c2785af46c655e8f21397f1a80ef96f43eb658c43d48a5d20a4a8b0b3e6a47"

  url "https://github.com/jobtools/audiocast-driver/releases/download/v#{version}/AudioCast-#{version}.pkg"
  name "AudioCast Driver"
  desc "Virtual audio device for AudioCast (BlackHole fork with AudioCast branding)"
  homepage "https://github.com/jobtools/audiocast-driver"

  depends_on macos: :sonoma

  pkg "AudioCast-#{version}.pkg"

  uninstall pkgutil: "com.audiocast.driver"

  caveats <<~CAVEATS
    After install, restart your Mac or run:
        sudo killall coreaudiod

    Then check System Settings → Sound — you should see 'AudioCast' as
    an output device.
  CAVEATS

  zap trash: [
    "/Library/Audio/Plug-Ins/HAL/AudioCast.driver",
  ]
end
