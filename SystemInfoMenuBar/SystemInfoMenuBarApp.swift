import SwiftUI
import SystemInfoKit

@main
struct SystemInfoMenuBarApp: App {
    @StateObject private var monitor = SystemMonitor()

    var body: some Scene {
        MenuBarExtra {
            MenuBarContentView(monitor: monitor)
        } label: {
            Label("System Info", systemImage: "cpu")
        }
        .menuBarExtraStyle(.window)
    }
}
