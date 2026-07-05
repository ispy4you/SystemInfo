import SwiftUI
import SystemInfoKit

struct SettingsView: View {
    @EnvironmentObject private var monitor: SystemMonitor
    @State private var selectedInterval: UpdateInterval = AppSettings.updateInterval

    var body: some View {
        Form {
            Section("Live Updates") {
                Picker("Update Interval", selection: $selectedInterval) {
                    ForEach(UpdateInterval.allCases) { interval in
                        Text(interval.label).tag(interval)
                    }
                }
                .onChange(of: selectedInterval) { newValue in
                    monitor.updateInterval = newValue
                }
            }

            Section("About") {
                LabeledContent("App", value: "System Info")
                LabeledContent("Charts Window", value: "60 samples")
                LabeledContent("Minimum OS", value: "iOS 16 / macOS 13")
            }
        }
        .navigationTitle("Settings")
        #if os(macOS)
        .formStyle(.grouped)
        #endif
    }
}
