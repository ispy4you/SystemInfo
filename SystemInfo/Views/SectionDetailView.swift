import SwiftUI
import SystemInfoKit

struct SectionDetailView: View {
    let section: AppSection
    @EnvironmentObject private var monitor: SystemMonitor

    var body: some View {
        ScrollView {
            content
                .padding()
        }
        .navigationTitle(section.rawValue)
        #if os(iOS)
        .background(Color(.systemGroupedBackground))
        #else
        .background(Color(nsColor: .windowBackgroundColor))
        #endif
    }

    @ViewBuilder
    private var content: some View {
        switch section {
        case .overview:
            OverviewView()
        case .device:
            DeviceInfoSection()
        case .power:
            PowerSection(power: monitor.power)
        case .storage:
            StorageSection(storage: monitor.storage)
        case .memory:
            MemorySection(usagePercent: monitor.currentMemory)
        case .processor:
            ProcessorSection(cpuPercent: monitor.currentCPU)
        case .charts:
            ChartsSection()
        case .network:
            NetworkSection(network: monitor.network)
        case .settings:
            SettingsView()
        }
    }
}
