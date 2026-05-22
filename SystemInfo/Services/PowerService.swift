import Foundation

#if canImport(UIKit)
import UIKit
#endif

struct PowerInfo {
    let levelPercent: Double?
    let stateDescription: String
    let isCharging: Bool
}

enum PowerService {
    #if os(iOS)
    static func current() -> PowerInfo {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        let level = device.batteryLevel >= 0 ? Double(device.batteryLevel) * 100 : nil
        let state: String
        let charging: Bool
        switch device.batteryState {
        case .charging:
            state = "Charging"
            charging = true
        case .full:
            state = "Full"
            charging = false
        case .unplugged:
            state = "Unplugged"
            charging = false
        default:
            state = "Unknown"
            charging = false
        }
        return PowerInfo(levelPercent: level, stateDescription: state, isCharging: charging)
    }
    #else
    static func current() -> PowerInfo {
        let lowPower = ProcessInfo.processInfo.isLowPowerModeEnabled
        let thermal = ProcessInfo.processInfo.thermalState
        let thermalText: String
        switch thermal {
        case .nominal: thermalText = "Nominal"
        case .fair: thermalText = "Fair"
        case .serious: thermalText = "Serious"
        case .critical: thermalText = "Critical"
        @unknown default: thermalText = "Unknown"
        }
        let state = "Thermal: \(thermalText)" + (lowPower ? " · Low Power Mode" : "")
        return PowerInfo(levelPercent: nil, stateDescription: state, isCharging: false)
    }
    #endif
}
