import SwiftUI
import SystemInfoKit

struct RootView: View {
    @EnvironmentObject private var monitor: SystemMonitor
    @State private var selection: AppSection? = .overview

    var body: some View {
        #if os(macOS)
        macLayout
        #else
        iosLayout
        #endif
    }

    #if os(macOS)
    private var macLayout: some View {
        NavigationSplitView {
            List(AppSection.allCases, selection: $selection) { section in
                Label(section.rawValue, systemImage: section.icon)
                    .tag(section)
            }
            .navigationTitle("System Info")
            .toolbar { refreshToolbar }
        } detail: {
            if let selection {
                SectionDetailView(section: selection)
                    .refreshable { await refresh() }
                    .toolbar { refreshToolbar }
            } else {
                Text("Select a section")
                    .foregroundStyle(.secondary)
            }
        }
        .onAppear { if selection == nil { selection = .overview } }
    }
    #endif

    #if os(iOS)
    private var iosLayout: some View {
        TabView {
            NavigationStack {
                ScrollView {
                    VStack(spacing: 16) {
                        OverviewView()
                        MemorySection(usagePercent: monitor.currentMemory)
                        ProcessorSection(cpuPercent: monitor.currentCPU)
                    }
                    .padding()
                }
                .refreshable { await refresh() }
                .background(Color(.systemGroupedBackground))
                .navigationTitle("System Info")
                .toolbar { refreshToolbar }
            }
            .tabItem { Label("Dashboard", systemImage: "square.grid.2x2") }

            NavigationStack {
                List {
                    ForEach(AppSection.allCases.filter { ![.overview, .charts, .settings].contains($0) }) { section in
                        NavigationLink {
                            SectionDetailView(section: section)
                                .refreshable { await refresh() }
                        } label: {
                            Label(section.rawValue, systemImage: section.icon)
                        }
                    }
                }
                .navigationTitle("System")
                .refreshable { await refresh() }
                .toolbar { refreshToolbar }
            }
            .tabItem { Label("System", systemImage: "list.bullet.rectangle") }

            NavigationStack {
                SectionDetailView(section: .charts)
                    .refreshable { await refresh() }
                    .toolbar { refreshToolbar }
            }
            .tabItem { Label("Charts", systemImage: "chart.xyaxis.line") }

            NavigationStack {
                SettingsView()
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
    #endif

    @ToolbarContentBuilder
    private var refreshToolbar: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                monitor.refreshAll()
            } label: {
                Image(systemName: "arrow.clockwise")
            }
            .help("Refresh")
        }
    }

    private func refresh() async {
        monitor.refreshAll()
    }
}
