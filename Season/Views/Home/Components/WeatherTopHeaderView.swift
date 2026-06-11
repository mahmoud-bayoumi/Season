//
//  WeatherTopHeaderView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI

struct WeatherTopHeaderView: View {
    let weather: WeatherResponse
    let themeColor: Color
    var showIcon: Bool = true 
    
    var body: some View {
        VStack(spacing: 4) {
            Text(weather.location.name)
                .font(.system(size: 36, weight: .medium))
            Text("\(Int(weather.current.tempC))°")
                .font(.system(size: 76, weight: .thin))
            Text(weather.current.condition.text)
                .font(.title3)
                .fontWeight(.light)
            
            if let today = weather.forecast.forecastday.first {
                Text("H:\(Int(today.day.maxtempC))° L:\(Int(today.day.mintempC))°")
                    .font(.subheadline)
            }
            
            if showIcon {
                WeatherIconView(iconUrlString: weather.current.condition.icon)
                    .frame(width: 50, height: 50)
                    .padding(.top, 4)
            }
        }
        .foregroundColor(themeColor)
        .padding(.top, 10)
    }
}

