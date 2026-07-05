import SwiftUI
import SystemInfoKit

struct MenuBarContentView: View {
    @ObservedObject var monitor: SystemMonitor

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("System Info")
                .font(.headline)

            metricRow(title: "CPU", value: monitor.currentCPU, color: .blue)
            metricRow(title: "Memory", value: monitor.currentMemory, color: .purple)

            if let storage = monitor.storage {
                metricRow(title: "Storage Used", value: storage.usedFraction * 100, color: .orange)
            }

            if let level = monitor.power.levelPercent {
                metricRow(title: "Battery", value: level, color: monitor.power.isCharging ? .green : .blue)
            }

            Divider()

            HStack {
                Button("Refresh") { monitor.refreshAll() }
                Spacer()
                Button("Quit") { NSApplication.shared.terminate(nil) }
            }
            .font(.caption)
            .buttonStyle(.plain)
            .foregroundStyle(.tint)
        }
        .padding(16)
        .frame(width: 260)
    }

    private func metricRow(title: String, value: Double, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Text(String(format: "%.0f%%", value))
                    .font(.caption.weight(.semibold))
            }
            ProgressView(value: value / 100)
                .tint(color)
        }
    }
}
