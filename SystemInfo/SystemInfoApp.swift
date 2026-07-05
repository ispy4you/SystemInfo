import SwiftUI
import SystemInfoKit

@main
struct SystemInfoApp: App {
    @StateObject private var monitor = SystemMonitor()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(monitor)
        }
        #if os(macOS)
        .defaultSize(width: 1100, height: 780)
        #endif
    }
}
