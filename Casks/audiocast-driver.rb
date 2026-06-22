cask "audiocast-driver" do
  version "1.1.11"
  sha256 "94b31b7df2c2da88decba67a39c2cf43e174a131db15f2049afebf6057199193"

  url "https://github.com/jobtools/audiocast-driver/releases/download/v#{version}/AudioCast-#{version}.pkg"
  name "AudioCast Driver"
  desc "Virtual audio device for AudioCast (BlackHole fork with AudioCast branding)"
  homepage "https://github.com/jobtools/audiocast-driver"

  depends_on macos: :sonoma

  pkg "AudioCast-#{version}.pkg"

  uninstall pkgutil: "com.audiocast.driver"

  caveats <<~CAVEATS
    AudioCast Driver is self-signed (not Apple-notarized).

    After install, restart your Mac or run:
        sudo killall coreaudiod

    Then check System Settings → Sound — you should see 'AudioCast' as
    an output device.
  CAVEATS

  zap trash: [
    "/Library/Audio/Plug-Ins/HAL/AudioCast.driver",
  ]
end
