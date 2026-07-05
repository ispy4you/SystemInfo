import SwiftUI
import SystemInfoKit

struct ChartsSection: View {
    @EnvironmentObject private var monitor: SystemMonitor

    var body: some View {
        VStack(spacing: 16) {
            MetricLineChart(
                title: "CPU Usage",
                samples: monitor.cpuSeries.samples,
                color: .blue,
                unitLabel: "CPU"
            )
            MetricLineChart(
                title: "Memory Usage",
                samples: monitor.memorySeries.samples,
                color: .purple,
                unitLabel: "Memory"
            )
            Text("Showing the last 60 samples · updates follow Settings interval")
                .font(.caption)
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
