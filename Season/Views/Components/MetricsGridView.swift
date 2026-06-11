//
//  HomeMetricsGridView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct MetricsGridView: View {
    let weather: WeatherResponse
    let themeColor: Color
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            MetricCardView(
                title: "UV INDEX",
                value: String(format: "%.0f", weather.current.uv),
                subtitle: uvExposureLevel(weather.current.uv),
                textColor: themeColor
            )
            MetricCardView(
                title: "WIND",
                value: "\(Int(weather.current.windKph)) km/h",
                subtitle: "Gusts up to \(Int(weather.current.gustKph)) km/h",
                textColor: themeColor
            )
            MetricCardView(
                title: "PRECIPITATION",
                value: "\(weather.current.precipMm) mm",
                subtitle: "Chance of rain: \(weather.forecast.forecastday.first?.day.dailyChanceOfRain ?? 0)%",
                textColor: themeColor
            )
            MetricCardView(
                title: "FEELS LIKE",
                value: "\(Int(weather.current.feelslikeC))°",
                subtitle: humidityImpactMessage(weather.current.tempC, feelsLike: weather.current.feelslikeC),
                textColor: themeColor
            )
            MetricCardView(
                title: "HUMIDITY",
                value: "\(weather.current.humidity)%",
                subtitle: "Dew point is \(Int(weather.current.feelslikeC - 5))°", // Approximate text
                textColor: themeColor
            )
            MetricCardView(
                title: "VISIBILITY",
                value: "\(Int(weather.current.visKm)) km",
                subtitle: weather.current.visKm >= 10 ? "Perfectly clear view" : "Slight haze present",
                textColor: themeColor
            )
        }
    }
    
    private func uvExposureLevel(_ value: Double) -> String {
        if value <= 2 { return "Low exposure" }
        else if value <= 5 { return "Moderate risk" }
        else if value <= 7 { return "High exposure" }
        else { return "Very high risk" }
    }
    
    private func humidityImpactMessage(_ temp: Double, feelsLike: Double) -> String {
        if feelsLike < temp { return "Wind chill cooling" }
        else if feelsLike > temp { return "Humidity makes it hotter" }
        else { return "Similar to actual temp" }
    }
}
