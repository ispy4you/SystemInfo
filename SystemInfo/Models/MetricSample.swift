import Foundation

struct MetricSample: Identifiable, Equatable {
    let id = UUID()
    let timestamp: Date
    let value: Double
}

struct ChartSeries {
    var samples: [MetricSample] = []
    let maxCount: Int = 60

    mutating func append(_ value: Double, at date: Date = Date()) {
        samples.append(MetricSample(timestamp: date, value: value))
        if samples.count > maxCount {
            samples.removeFirst(samples.count - maxCount)
        }
    }
}

enum AppSection: String, CaseIterable, Identifiable {
    case overview = "Overview"
    case device = "Device"
    case power = "Power"
    case storage = "Storage"
    case memory = "Memory"
    case processor = "Processor"
    case charts = "Charts"
    case network = "Network"
    case settings = "Settings"

    var id: String { rawValue }

    var icon: String {
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
