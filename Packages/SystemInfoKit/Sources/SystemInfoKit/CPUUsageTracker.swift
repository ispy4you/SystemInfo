import Darwin
import Foundation

/// Tracks CPU usage deltas between successive samples. Each instance owns its
/// own baseline, so multiple trackers (e.g. app + widget + menu bar extra)
/// can sample independently without clobbering each other's state.
final class CPUUsageTracker {
    private var previousInfo: host_cpu_load_info?

    func usagePercent() -> Double {
        var size = mach_msg_type_number_t(
            MemoryLayout<host_cpu_load_info>.stride / MemoryLayout<integer_t>.size
        )
        var cpuInfo = host_cpu_load_info()
        let result = withUnsafeMutablePointer(to: &cpuInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &size)
            }
        }
        guard result == KERN_SUCCESS else { return 0 }

        defer { previousInfo = cpuInfo }

        guard let previous = previousInfo else { return 0 }

        let user = Double(cpuInfo.cpu_ticks.0 - previous.cpu_ticks.0)
        let system = Double(cpuInfo.cpu_ticks.1 - previous.cpu_ticks.1)
        let idle = Double(cpuInfo.cpu_ticks.2 - previous.cpu_ticks.2)
        let nice = Double(cpuInfo.cpu_ticks.3 - previous.cpu_ticks.3)
        let total = user + system + idle + nice
        guard total > 0 else { return 0 }
        return min(((user + system + nice) / total) * 100, 100)
    }
}
