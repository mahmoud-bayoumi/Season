//
//  WeatherMetricsGridView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI

struct WeatherMetricsGridView: View {
    let weather: WeatherResponse
    let themeColor: Color
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            WeatherMetricCard(title: "VISIBILITY", value: "\(Int(weather.current.visKm)) km", textColor: themeColor)
            WeatherMetricCard(title: "HUMIDITY", value: "\(weather.current.humidity)%", textColor: themeColor)
            WeatherMetricCard(title: "FEELS LIKE", value: "\(Int(weather.current.feelslikeC))°", textColor: themeColor)
            WeatherMetricCard(title: "PRESSURE", value: String(format: "%.0f mb", weather.current.pressureMb), textColor: themeColor)
        }
    }
}


