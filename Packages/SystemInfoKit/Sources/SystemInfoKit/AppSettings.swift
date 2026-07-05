import Foundation

public enum UpdateInterval: Int, CaseIterable, Identifiable {
    case one = 1
    case two = 2
    case five = 5

    public var id: Int { rawValue }

    public var label: String {
        switch self {
        case .one: return "1 second"
        case .two: return "2 seconds"
        case .five: return "5 seconds"
        }
    }

    public var timeInterval: TimeInterval { TimeInterval(rawValue) }
}

public enum AppSettings {
    static let updateIntervalKey = "updateIntervalSeconds"

    public static var updateInterval: UpdateInterval {
        get {
            let raw = UserDefaults.standard.integer(forKey: updateIntervalKey)
            return UpdateInterval(rawValue: raw) ?? .one
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: updateIntervalKey)
        }
    }
}
