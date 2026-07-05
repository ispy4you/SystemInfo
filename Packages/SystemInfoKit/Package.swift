// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SystemInfoKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "SystemInfoKit", targets: ["SystemInfoKit"])
    ],
    targets: [
        .target(name: "SystemInfoKit"),
        .testTarget(name: "SystemInfoKitTests", dependencies: ["SystemInfoKit"])
    ]
)
