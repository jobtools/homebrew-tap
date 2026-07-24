# jobtools/homebrew-tap

Homebrew tap for [jobtools](https://github.com/jobtools) apps and tools.

## Usage

```bash
brew tap jobtools/tap
brew install --cask audiocast
```

The `audiocast` cask depends on `audiocast-driver` and pulls it in
automatically. Installing the driver standalone:

```bash
brew install --cask audiocast-driver
```

## Casks

- **audiocast** — [AudioCast](https://github.com/jobtools/audiocast):
  stream macOS system audio to an Android phone over Wi-Fi.
- **audiocast-driver** — virtual HAL audio device used by AudioCast
  (BlackHole fork).

## Formulae

- **android-run** — build, install and launch any Android Gradle project's
  debug APK on a connected device/emulator.

```bash
brew install jobtools/tap/android-run
```

Then, from anywhere inside a Gradle project:

```bash
android-run                       # build :app:assembleDebug → install → launch
android-run -m feature-x          # target another module
android-run -s emulator-5554 -y   # pick a device; auto-uninstall on conflict
android-run --no-launch           # build + install only
```

It walks up to find `gradlew`, reads the application id and launcher
activity straight from the built APK, and starts it. If an incompatible
build is already installed (signature/version mismatch) it offers to
uninstall and reinstall (`-y` to do it without asking). Needs the Android
SDK (`ANDROID_HOME`, or `~/Library/Android/sdk`) with `adb` + build-tools.
