import SwiftUI
import SystemInfoKit

struct ProcessorSection: View {
    let cpuPercent: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Processor", systemImage: "cpu")
            VStack(spacing: 10) {
                CopyableValueRow(
                    label: "Cores",
                    value: "\(SystemSampler.activeProcessorCount()) active / \(SystemSampler.processorCount()) total"
                )
                CopyableValueRow(label: "Architecture", value: SystemSampler.architectureDescription())
                CopyableValueRow(label: "Current CPU Load", value: Formatters.percent(cpuPercent))
            }
        }
        .cardStyle()
    }
}
