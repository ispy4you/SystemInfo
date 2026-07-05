# System Info

[![CI](https://github.com/ispy4you/SystemInfo/actions/workflows/ci.yml/badge.svg)](https://github.com/ispy4you/SystemInfo/actions/workflows/ci.yml)

A native SwiftUI multiplatform app for **iOS 16+** and **macOS 13+** that displays detailed system information with real-time CPU and memory charts.

## Features

- Device, power/battery, storage, memory, processor, and network sections
- Swift Charts line charts with a 60-sample rolling window
- Configurable update interval (1s / 2s / 5s) in Settings
- Pull-to-refresh and toolbar refresh
- Copy any value via button, context menu, or long press (iOS)
- Adaptive layout: tabs on iPhone, sidebar + detail on Mac
- Light and dark mode via system appearance
- **SystemInfoMenuBar**: a lightweight macOS menu bar extra showing live CPU/memory/storage/battery, sharing the same engine as the main app

## Requirements

- Xcode 15 or later
- iOS 16+ / macOS 13+ SDKs

## Tests

All sampling/business logic lives in the local Swift package `Packages/SystemInfoKit` and is covered by unit tests there (`SystemSampler`, `StorageService`, `AppSettings`, `ChartSeries`, `CPUUsageTracker`). Run them directly with SwiftPM — no simulator, no Xcode project needed:

```bash
swift test --package-path Packages/SystemInfoKit
```

GitHub Actions (`.github/workflows/ci.yml`) runs this test suite plus iOS/macOS app builds on every push and pull request to `main`.

## Open & Run

1. Open `SystemInfo.xcodeproj` in Xcode.
2. Select the **SystemInfo** scheme (main app) or **SystemInfoMenuBar** (macOS-only menu bar extra).
3. Choose an iOS Simulator, iPhone, or **My Mac** destination.
4. Press **Run** (⌘R).

`SystemInfoMenuBar` runs as a menu bar–only agent (no Dock icon, no windows) and shows live CPU, memory, storage, and battery/thermal stats in a popover, with Refresh and Quit actions.

If `git` failed during project creation because of the Xcode license, run:

```bash
sudo xcodebuild -license
```

Then initialize git if you want version control:

```bash
cd ~/SystemInfo && git init
```

## Architecture

The engine (models + services) lives in the local Swift package **`Packages/SystemInfoKit`**, kept separate from the SwiftUI app so it can be unit-tested without a UI target and reused across app targets.

| Layer | Location | Responsibility |
|-------|----------|----------------|
| `SystemMonitor` | SystemInfoKit | Timer-driven sampling, published metrics |
| `SystemSampler` / `CPUUsageTracker` | SystemInfoKit | Mach `host_statistics` CPU/memory |
| `DeviceInfoService` | SystemInfoKit | Model, name, OS, uptime |
| `PowerService` | SystemInfoKit | `UIDevice` battery (iOS) / thermal (macOS) |
| `StorageService` | SystemInfoKit | `FileManager` volume capacity |
| `NetworkService` | SystemInfoKit | `NWPathMonitor` + `getifaddrs` |
| `SystemInfo/Views/` | SystemInfo app | Full SwiftUI presentation (iOS + macOS), imports `SystemInfoKit` |
| `SystemInfoMenuBar/` | SystemInfoMenuBar app | `MenuBarExtra` popover UI, imports the same `SystemInfoKit`, no Dock icon (`LSUIElement`) |

## Privacy

Uses only on-device public APIs. No network requests are made by the app beyond reading the local interface address.
