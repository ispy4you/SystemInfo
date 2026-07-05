import Foundation

public struct StorageInfo {
    public let total: Int64
    public let available: Int64

    public var used: Int64 { max(total - available, 0) }

    public var usedFraction: Double {
        guard total > 0 else { return 0 }
        return Double(used) / Double(total)
    }
}

public enum StorageService {
    public static func current() -> StorageInfo? {
        let home = NSHomeDirectory()
        do {
            let values = try URL(fileURLWithPath: home)
                .resourceValues(forKeys: [
                    .volumeTotalCapacityKey,
                    .volumeAvailableCapacityForImportantUsageKey,
                    .volumeAvailableCapacityKey
                ])

            guard let total = values.volumeTotalCapacity else { return nil }
            let available: Int64
            if let important = values.volumeAvailableCapacityForImportantUsage {
                available = Int64(important)
            } else if let regular = values.volumeAvailableCapacity {
                available = Int64(regular)
            } else {
                available = 0
            }
            return StorageInfo(total: Int64(total), available: available)
        } catch {
            return nil
        }
    }
}
