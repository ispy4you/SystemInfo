import XCTest
@testable import SystemInfoKit

final class StorageServiceTests: XCTestCase {
    func testUsedIsDifferenceBetweenTotalAndAvailable() {
        let info = StorageInfo(total: 1_000, available: 400)
        XCTAssertEqual(info.used, 600)
    }

    func testUsedIsClampedToZeroWhenAvailableExceedsTotal() {
        let info = StorageInfo(total: 1_000, available: 1_500)
        XCTAssertEqual(info.used, 0)
    }

    func testUsedFractionIsZeroWhenTotalIsZero() {
        let info = StorageInfo(total: 0, available: 0)
        XCTAssertEqual(info.usedFraction, 0)
    }

    func testUsedFractionMatchesExpectedRatio() {
        let info = StorageInfo(total: 200, available: 50)
        XCTAssertEqual(info.usedFraction, 0.75, accuracy: 0.0001)
    }

    func testCurrentReturnsPlausibleValues() {
        guard let info = StorageService.current() else {
            return XCTFail("Expected volume capacity to be readable in test environment")
        }
        XCTAssertGreaterThan(info.total, 0)
        XCTAssertGreaterThanOrEqual(info.available, 0)
    }
}
