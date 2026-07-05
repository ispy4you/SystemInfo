import XCTest
@testable import SystemInfoKit

final class SystemSamplerTests: XCTestCase {
    func testMemoryUsageIsWithinPercentRange() {
        let usage = SystemSampler.memoryUsagePercent()
        XCTAssertGreaterThanOrEqual(usage, 0)
        XCTAssertLessThanOrEqual(usage, 100)
    }

    func testProcessorCountsAreConsistent() {
        XCTAssertGreaterThan(SystemSampler.processorCount(), 0)
        XCTAssertGreaterThan(SystemSampler.activeProcessorCount(), 0)
        XCTAssertLessThanOrEqual(SystemSampler.activeProcessorCount(), SystemSampler.processorCount())
    }

    func testArchitectureDescriptionIsNotEmpty() {
        XCTAssertFalse(SystemSampler.architectureDescription().isEmpty)
    }
}
