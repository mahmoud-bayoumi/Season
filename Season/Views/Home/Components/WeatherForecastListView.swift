//
//  WeatherForecastListView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI


struct WeatherForecastListView: View {
    let weather: WeatherResponse
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("3-DAY FORECAST")
                .font(.caption)
                .bold()
                .foregroundColor(viewModel.themeFontColor.opacity(0.6))
                .padding(.horizontal, 4)
            
            Divider().background(viewModel.themeFontColor.opacity(0.3))
            
            ForEach(weather.forecast.forecastday) { day in
                NavigationLink(destination: HourlyForecastView(forecastDay: day, viewModel: viewModel)) {
                    // Assumes you have your ForecastRowView handling the row UI
                    ForecastRowView(forecastDay: day, textColor: viewModel.themeFontColor)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}

