import SwiftUI

struct NetworkSection: View {
    @ObservedObject var network: NetworkService

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Network", systemImage: "wifi")
            VStack(spacing: 10) {
                CopyableValueRow(label: "Status", value: network.isConnected ? "Online" : "Offline")
                CopyableValueRow(label: "Connection", value: network.connectionType)
                CopyableValueRow(label: "Local IP", value: network.localIP)
            }
        }
        .cardStyle()
    }
}
