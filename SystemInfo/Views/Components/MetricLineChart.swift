import Charts
import SwiftUI
import SystemInfoKit

struct MetricLineChart: View {
    let title: String
    let samples: [MetricSample]
    let color: Color
    let unitLabel: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                if let latest = samples.last {
                    Text(Formatters.percent(latest.value))
                        .font(.title3.weight(.semibold))
                        .foregroundStyle(color)
                }
            }

            Chart(samples) { sample in
                LineMark(
                    x: .value("Time", sample.timestamp),
                    y: .value(unitLabel, sample.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(color.gradient)

                AreaMark(
                    x: .value("Time", sample.timestamp),
                    y: .value(unitLabel, sample.value)
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(color.opacity(0.18).gradient)
            }
            .chartYScale(domain: 0...100)
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 4)) { _ in
                    AxisGridLine()
                    AxisValueLabel(format: .dateTime.minute().second())
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading, values: [0, 25, 50, 75, 100]) { value in
                    AxisGridLine()
                    if let intValue = value.as(Int.self) {
                        AxisValueLabel("\(intValue)%")
                    }
                }
            }
            .frame(height: 180)
        }
        .cardStyle()
    }
}
