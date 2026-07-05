import Darwin
import Foundation

#if canImport(UIKit)
import UIKit
#endif

public enum DeviceInfoService {
    public static var deviceName: String {
        #if os(iOS)
        UIDevice.current.name
        #else
        ProcessInfo.processInfo.hostName
        #endif
    }

    public static var modelName: String {
        #if os(iOS)
        var systemInfo = utsname()
        uname(&systemInfo)
        let identifier = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                String(cString: $0)
            }
        }
        return friendlyModelName(for: identifier) ?? identifier
        #else
        var size = 0
        sysctlbyname("hw.model", nil, &size, nil, 0)
        var model = [CChar](repeating: 0, count: size)
        sysctlbyname("hw.model", &model, &size, nil, 0)
        return String(cString: model)
        #endif
    }

    public static var osVersion: String {
        let version = ProcessInfo.processInfo.operatingSystemVersion
        return "\(ProcessInfo.processInfo.operatingSystemVersionString) (\(version.majorVersion).\(version.minorVersion).\(version.patchVersion))"
    }

    public static var uptime: TimeInterval {
        ProcessInfo.processInfo.systemUptime
    }

    #if os(iOS)
    private static func friendlyModelName(for identifier: String) -> String? {
        let map: [String: String] = [
            "iPhone15,2": "iPhone 14 Pro",
            "iPhone15,3": "iPhone 14 Pro Max",
            "iPhone15,4": "iPhone 15",
            "iPhone15,5": "iPhone 15 Plus",
            "iPhone16,1": "iPhone 15 Pro",
            "iPhone16,2": "iPhone 15 Pro Max",
            "iPad13,18": "iPad (10th generation)",
            "iPad14,3": "iPad Pro 11-inch (4th generation)"
        ]
        return map[identifier] ?? identifier
    }
    #endif
}
