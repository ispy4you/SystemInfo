# System Info

A native SwiftUI multiplatform app for **iOS 16+** and **macOS 13+** that displays detailed system information with real-time CPU and memory charts.

## Features

- Device, power/battery, storage, memory, processor, and network sections
- Swift Charts line charts with a 60-sample rolling window
- Configurable update interval (1s / 2s / 5s) in Settings
- Pull-to-refresh and toolbar refresh
- Copy any value via button, context menu, or long press (iOS)
- Adaptive layout: tabs on iPhone, sidebar + detail on Mac
- Light and dark mode via system appearance

## Requirements

- Xcode 15 or later
- iOS 16+ / macOS 13+ SDKs

## Open & Run

1. Open `SystemInfo.xcodeproj` in Xcode.
2. Select the **SystemInfo** scheme.
3. Choose an iOS Simulator, iPhone, or **My Mac** destination.
4. Press **Run** (⌘R).

If `git` failed during project creation because of the Xcode license, run:

```bash
sudo xcodebuild -license
```

Then initialize git if you want version control:

```bash
cd ~/SystemInfo && git init
```

## Architecture

| Layer | Responsibility |
|-------|----------------|
| `SystemMonitor` | Timer-driven sampling, published metrics |
| `SystemSampler` | Mach `host_statistics` CPU/memory |
| `DeviceInfoService` | Model, name, OS, uptime |
| `PowerService` | `UIDevice` battery (iOS) / thermal (macOS) |
| `StorageService` | `FileManager` volume capacity |
| `NetworkService` | `NWPathMonitor` + `getifaddrs` |

## Privacy

Uses only on-device public APIs. No network requests are made by the app beyond reading the local interface address.
