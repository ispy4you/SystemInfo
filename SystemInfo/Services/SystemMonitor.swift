import Combine
import Foundation

@MainActor
final class SystemMonitor: ObservableObject {
    @Published private(set) var cpuSeries = ChartSeries()
    @Published private(set) var memorySeries = ChartSeries()
    @Published private(set) var currentCPU: Double = 0
    @Published private(set) var currentMemory: Double = 0
    @Published private(set) var storage = StorageService.current()
    @Published private(set) var power = PowerService.current()
    @Published var lastRefreshed = Date()

    let network = NetworkService()

    private var timer: Timer?
    private var cancellables = Set<AnyCancellable>()

    init() {
        refreshStaticData()
        startTimer()
    }

    deinit {
        timer?.invalidate()
    }

    var updateInterval: UpdateInterval {
        get { AppSettings.updateInterval }
        set {
            AppSettings.updateInterval = newValue
            restartTimer()
        }
    }

    func refreshAll() {
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
        let cpu = SystemSampler.cpuUsagePercent()
        let memory = SystemSampler.memoryUsagePercent()
        currentCPU = cpu
        currentMemory = memory
        cpuSeries.append(cpu)
        memorySeries.append(memory)
    }
}
