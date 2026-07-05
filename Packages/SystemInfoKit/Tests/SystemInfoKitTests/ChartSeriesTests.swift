import XCTest
@testable import SystemInfoKit

final class ChartSeriesTests: XCTestCase {
    func testAppendAddsSample() {
        var series = ChartSeries()
        series.append(42)
        XCTAssertEqual(series.samples.count, 1)
        XCTAssertEqual(series.samples.first?.value, 42)
    }

    func testAppendTrimsToMaxCount() {
        var series = ChartSeries()
        for value in 0..<(series.maxCount + 10) {
            series.append(Double(value))
        }
        XCTAssertEqual(series.samples.count, series.maxCount)
        XCTAssertEqual(series.samples.first?.value, 10)
        XCTAssertEqual(series.samples.last?.value, Double(series.maxCount + 9))
    }
}
