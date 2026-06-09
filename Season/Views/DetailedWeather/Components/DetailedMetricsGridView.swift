//
//  DetailedMetricsGridView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct DetailedMetricsGridView: View {
    let weather: WeatherResponse
    let themeColor: Color
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            MetricCard(title: "VISIBILITY", value: "\(Int(weather.current.visKm)) km", textColor: themeColor)
            MetricCard(title: "HUMIDITY", value: "\(weather.current.humidity)%", textColor: themeColor)
            MetricCard(title: "FEELS LIKE", value: "\(Int(weather.current.feelslikeC))°", textColor: themeColor)
            MetricCard(title: "PRESSURE", value: String(format: "%.0f mb", weather.current.pressureMb), textColor: themeColor)
        }
        .padding(.horizontal)
    }
}

