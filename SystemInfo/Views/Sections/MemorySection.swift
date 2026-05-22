import SwiftUI

struct MemorySection: View {
    let usagePercent: Double

    private var totalBytes: UInt64 {
        ProcessInfo.processInfo.physicalMemory
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Memory", systemImage: "memorychip")
            VStack(spacing: 10) {
                CopyableValueRow(label: "Physical RAM", value: Formatters.bytes(Int64(totalBytes)))
                CopyableValueRow(label: "Usage", value: Formatters.percent(usagePercent))
                ProgressView(value: usagePercent / 100)
                    .tint(.purple)
            }
        }
        .cardStyle()
    }
}
