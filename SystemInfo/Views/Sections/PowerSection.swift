import SwiftUI

struct PowerSection: View {
    let power: PowerInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            #if os(iOS)
            SectionHeader(title: "Battery", systemImage: "battery.100")
            #else
            SectionHeader(title: "Power", systemImage: "bolt.fill")
            #endif

            VStack(spacing: 10) {
                if let level = power.levelPercent {
                    CopyableValueRow(label: "Level", value: Formatters.percent(level, fractionDigits: 0))
                    ProgressView(value: level / 100)
                        .tint(power.isCharging ? .green : .blue)
                }
                CopyableValueRow(label: "State", value: power.stateDescription)
            }
        }
        .cardStyle()
    }
}
