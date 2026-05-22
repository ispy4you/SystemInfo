import Foundation

enum Formatters {
    static let byteCount: ByteCountFormatter = {
        let formatter = ByteCountFormatter()
        formatter.countStyle = .file
        formatter.allowedUnits = [.useGB, .useMB, .useKB]
        return formatter
    }()

    static func bytes(_ value: Int64) -> String {
        byteCount.string(fromByteCount: value)
    }

    static func percent(_ value: Double, fractionDigits: Int = 1) -> String {
        String(format: "%.\(fractionDigits)f%%", value)
    }

    static func uptime(_ interval: TimeInterval) -> String {
        let seconds = Int(interval)
        let days = seconds / 86_400
        let hours = (seconds % 86_400) / 3_600
        let minutes = (seconds % 3_600) / 60
        let secs = seconds % 60
        if days > 0 {
            return String(format: "%dd %02dh %02dm", days, hours, minutes)
        }
        return String(format: "%02dh %02dm %02ds", hours, minutes, secs)
    }
}
