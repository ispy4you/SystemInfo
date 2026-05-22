import Foundation

enum UpdateInterval: Int, CaseIterable, Identifiable {
    case one = 1
    case two = 2
    case five = 5

    var id: Int { rawValue }

    var label: String {
        switch self {
        case .one: return "1 second"
        case .two: return "2 seconds"
        case .five: return "5 seconds"
        }
    }

    var timeInterval: TimeInterval { TimeInterval(rawValue) }
}

enum AppSettings {
    static let updateIntervalKey = "updateIntervalSeconds"

    static var updateInterval: UpdateInterval {
        get {
            let raw = UserDefaults.standard.integer(forKey: updateIntervalKey)
            return UpdateInterval(rawValue: raw) ?? .one
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: updateIntervalKey)
        }
    }
}
