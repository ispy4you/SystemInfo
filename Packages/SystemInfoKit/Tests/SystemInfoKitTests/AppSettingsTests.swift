import XCTest
@testable import SystemInfoKit

final class AppSettingsTests: XCTestCase {
    private var originalInterval: UpdateInterval!

    override func setUp() {
        super.setUp()
        originalInterval = AppSettings.updateInterval
    }

    override func tearDown() {
        AppSettings.updateInterval = originalInterval
        super.tearDown()
    }

    func testUpdateIntervalRoundTrips() {
        AppSettings.updateInterval = .five
        XCTAssertEqual(AppSettings.updateInterval, .five)

        AppSettings.updateInterval = .two
        XCTAssertEqual(AppSettings.updateInterval, .two)
    }

    func testUpdateIntervalTimeIntervalMatchesRawValue() {
        for interval in UpdateInterval.allCases {
            XCTAssertEqual(interval.timeInterval, TimeInterval(interval.rawValue))
        }
    }

    func testUpdateIntervalLabelsAreNotEmpty() {
        for interval in UpdateInterval.allCases {
            XCTAssertFalse(interval.label.isEmpty)
        }
    }
}
