//
//  DetailedTopHeaderView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct DetailedTopHeaderView: View {
    let weather: WeatherResponse
    let themeColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(weather.location.name)
                .font(.system(size: 36, weight: .medium))
            Text("\(Int(weather.current.tempC))°")
                .font(.system(size: 72, weight: .thin))
            Text(weather.current.condition.text)
                .font(.title3)
            
            if let todayForecast = weather.forecast.forecastday.first {
                Text("H:\(Int(todayForecast.day.maxtempC))°  L:\(Int(todayForecast.day.mintempC))°")
                    .font(.subheadline)
            }
        }
        .foregroundColor(themeColor)
        .padding(.top, 20)
    }
}

