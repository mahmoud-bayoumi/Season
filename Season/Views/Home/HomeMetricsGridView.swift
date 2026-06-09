//
//  HomeMetricsGridView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct HomeMetricsGridView: View {
    let weather: WeatherResponse
    let themeColor: Color
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
            MetricCardView(title: "Visibility", value: "\(Int(weather.current.visKm)) km", textColor: themeColor)
            MetricCardView(title: "Humidity", value: "\(weather.current.humidity)%", textColor: themeColor)
            MetricCardView(title: "Feels Like", value: "\(Int(weather.current.feelslikeC))°", textColor: themeColor)
            MetricCardView(title: "Pressure", value: String(format: "%.0f mb", weather.current.pressureMb), textColor: themeColor)
        }
    }
}
