import SwiftUI
import SystemInfoKit

struct StorageSection: View {
    let storage: StorageInfo?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Storage", systemImage: "internaldrive")

            if let storage {
                VStack(spacing: 10) {
                    CopyableValueRow(label: "Total", value: Formatters.bytes(storage.total))
                    CopyableValueRow(label: "Used", value: Formatters.bytes(storage.used))
                    CopyableValueRow(label: "Available", value: Formatters.bytes(storage.available))
                    ProgressView(value: storage.usedFraction)
                        .tint(.orange)
                    Text("\(Formatters.percent(storage.usedFraction * 100, fractionDigits: 0)) used")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("Storage information unavailable")
                    .foregroundStyle(.secondary)
            }
        }
        .cardStyle()
    }
}
