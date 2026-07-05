import XCTest
@testable import SystemInfoKit

final class CPUUsageTrackerTests: XCTestCase {
    func testFirstSampleReturnsZeroBaseline() {
        let tracker = CPUUsageTracker()
        XCTAssertEqual(tracker.usagePercent(), 0)
    }

    func testSecondSampleIsWithinPercentRange() {
        let tracker = CPUUsageTracker()
        _ = tracker.usagePercent()
        let usage = tracker.usagePercent()
        XCTAssertGreaterThanOrEqual(usage, 0)
        XCTAssertLessThanOrEqual(usage, 100)
    }

    func testIndependentTrackersDoNotShareState() {
        let a = CPUUsageTracker()
        let b = CPUUsageTracker()
        XCTAssertEqual(a.usagePercent(), 0)
        XCTAssertEqual(b.usagePercent(), 0, "A fresh tracker must not inherit another tracker's baseline")
    }
}
