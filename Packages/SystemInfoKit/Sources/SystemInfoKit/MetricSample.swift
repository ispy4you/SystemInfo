import Foundation

public struct MetricSample: Identifiable, Equatable {
    public let id = UUID()
    public let timestamp: Date
    public let value: Double
}

public struct ChartSeries {
    public var samples: [MetricSample] = []
    let maxCount: Int = 60

    mutating func append(_ value: Double, at date: Date = Date()) {
        samples.append(MetricSample(timestamp: date, value: value))
        if samples.count > maxCount {
            samples.removeFirst(samples.count - maxCount)
        }
    }
}

public enum AppSection: String, CaseIterable, Identifiable {
    case overview = "Overview"
    case device = "Device"
    case power = "Power"
    case storage = "Storage"
    case memory = "Memory"
    case processor = "Processor"
    case charts = "Charts"
    case network = "Network"
    case settings = "Settings"

    public var id: String { rawValue }

    public var icon: String {
        switch self {
        case .overview: return "square.grid.2x2"
        case .device: return "iphone"
        case .power: return "battery.100"
        case .storage: return "internaldrive"
        case .memory: return "memorychip"
        case .processor: return "cpu"
        case .charts: return "chart.xyaxis.line"
        case .network: return "wifi"
        case .settings: return "gearshape"
        }
    }
}
