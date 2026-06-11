//
//  HomeTopPane.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct HomeTopPanelView: View {
    let weather: WeatherResponse
    let themeColor: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(weather.location.name)
                .font(.system(size: 34, weight: .medium))
            Text("\(Int(weather.current.tempC))°")
                .font(.system(size: 76, weight: .thin))
            Text(weather.current.condition.text)
                .font(.title3)
                .fontWeight(.light)
            if let today = weather.forecast.forecastday.first {
                Text("H:\(Int(today.day.maxtempC))° L:\(Int(today.day.mintempC))°")
                    .font(.subheadline)
            }
            WeatherIconView(iconUrlString: weather.current.condition.icon)
                .frame(width: 50, height: 50)
        }
        .foregroundColor(themeColor)
        .padding(.top, 10)
    }
}


