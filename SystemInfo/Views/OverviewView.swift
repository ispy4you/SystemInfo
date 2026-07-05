import SwiftUI
import SystemInfoKit

struct OverviewView: View {
    @EnvironmentObject private var monitor: SystemMonitor

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                StatBadge(title: "CPU", value: Formatters.percent(monitor.currentCPU), color: .blue)
                StatBadge(title: "Memory", value: Formatters.percent(monitor.currentMemory), color: .purple)
            }
            DeviceInfoSection()
            PowerSection(power: monitor.power)
            if let storage = monitor.storage {
                StorageSection(storage: storage)
            }
            NetworkSection(network: monitor.network)
        }
    }
}

private struct StatBadge: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title2.weight(.bold))
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}
