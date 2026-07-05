import Combine
import Foundation

@MainActor
public final class SystemMonitor: ObservableObject {
    @Published public private(set) var cpuSeries = ChartSeries()
    @Published public private(set) var memorySeries = ChartSeries()
    @Published public private(set) var currentCPU: Double = 0
    @Published public private(set) var currentMemory: Double = 0
    @Published public private(set) var storage = StorageService.current()
    @Published public private(set) var power = PowerService.current()
    @Published public var lastRefreshed = Date()

    public let network = NetworkService()

    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()
    private let cpuTracker = CPUUsageTracker()

    public init() {
        refreshStaticData()
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }

    public var updateInterval: UpdateInterval {
        get { AppSettings.updateInterval }
        set {
            AppSettings.updateInterval = newValue
            restartTimer()
        }
    }

    public func refreshAll() {
        refreshStaticData()
        sampleMetrics()
        network.refresh()
        lastRefreshed = Date()
    }

    func restartTimer() {
        timer?.invalidate()
        startTimer()
    }

    private func startTimer() {
        let interval = AppSettings.updateInterval.timeInterval
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.sampleMetrics()
            }
        }
        if let timer {
            RunLoop.main.add(timer, forMode: .common)
        }
        sampleMetrics()
    }

    private func refreshStaticData() {
        storage = StorageService.current()
        power = PowerService.current()
    }

    private func sampleMetrics() {
        let cpu = cpuTracker.usagePercent()
        let memory = SystemSampler.memoryUsagePercent()
        currentCPU = cpu
        currentMemory = memory
        cpuSeries.append(cpu)
        memorySeries.append(memory)
    }
}
