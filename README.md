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
