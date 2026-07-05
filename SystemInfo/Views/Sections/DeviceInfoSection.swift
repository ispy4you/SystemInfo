import SwiftUI
import SystemInfoKit

#if canImport(UIKit)
import UIKit
#endif

struct DeviceInfoSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Device Information", systemImage: "iphone.gen3")
            VStack(spacing: 10) {
                CopyableValueRow(label: "Model", value: DeviceInfoService.modelName)
                CopyableValueRow(label: "Name", value: DeviceInfoService.deviceName)
                CopyableValueRow(label: "OS Version", value: DeviceInfoService.osVersion)
                CopyableValueRow(label: "Uptime", value: Formatters.uptime(DeviceInfoService.uptime))
                #if os(iOS)
                CopyableValueRow(
                    label: "Display",
                    value: "\(Int(UIScreen.main.bounds.width))×\(Int(UIScreen.main.bounds.height)) @\(Int(UIScreen.main.scale))x"
                )
                #endif
            }
        }
        .cardStyle()
    }
}
