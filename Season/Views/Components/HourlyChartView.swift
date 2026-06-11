//
//  HomeHourlyChartView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI
import Charts

struct HourlyChartView: View {
    let hours: [Hour]
    let themeColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("24-HOUR TREND")
                .font(.caption)
                .bold()
                .foregroundColor(themeColor.opacity(0.6))
                .padding(.horizontal, 4)
            
            Divider().background(themeColor.opacity(0.3))
            
            Chart {
                ForEach(hours.prefix(24), id: \.timeEpoch) { hour in
                    if let date = parseDate(hour.time) {
                        LineMark(
                            x: .value("Time", date),
                            y: .value("Temperature", hour.tempC)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(themeColor)
                        
                        AreaMark(
                            x: .value("Time", date),
                            y: .value("Temperature", hour.tempC)
                        )
                        .interpolationMethod(.catmullRom)
                        .foregroundStyle(
                            LinearGradient(
                                colors: [themeColor.opacity(0.4), themeColor.opacity(0.0)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                    }
                }
            }
            .frame(height: 180)
            .chartYAxisLabel(position: .leading, alignment: .center) {
                Text("Temperature (°C)")
                    .font(.caption2)
                    .foregroundColor(themeColor.opacity(0.6))
            }
            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisGridLine().foregroundStyle(themeColor.opacity(0.15))
                    AxisValueLabel().foregroundStyle(themeColor.opacity(0.8))
                }
            }
            .chartXAxisLabel(position: .bottom, alignment: .center) {
                Text("Time of Day")
                    .font(.caption2)
                    .foregroundColor(themeColor.opacity(0.6))
                    .padding(.top, 4)
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .hour, count: 4)) { value in
                    if let date = value.as(Date.self) {
                        AxisValueLabel(format: .dateTime.hour(.defaultDigits(amPM: .abbreviated)))
                            .foregroundStyle(themeColor.opacity(0.8))
                    }
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
    
    private func parseDate(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.date(from: timeString)
    }
}
