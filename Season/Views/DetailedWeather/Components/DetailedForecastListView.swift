//
//  DetailedForecastListView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI


struct DetailedForecastListView: View {
    let weather: WeatherResponse
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("3-DAY FORECAST")
                .font(.caption)
                .bold()
                .foregroundColor(viewModel.themeFontColor.opacity(0.7))
                .padding(.horizontal)
            
            ForEach(weather.forecast.forecastday) { day in
                NavigationLink(destination: HourlyForecastView(forecastDay: day, viewModel: viewModel)) {
                    HStack {
                        Text(getDayName(from: day.date))
                            .frame(width: 80, alignment: .leading)
                        
                        Spacer()
                        
                        WeatherIconView(iconUrlString: day.day.condition.icon)
                            .frame(width: 32, height: 32)
                        
                        Spacer()
                        
                        Text("\(Int(day.day.mintempC))° - \(Int(day.day.maxtempC))°")
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .foregroundColor(viewModel.themeFontColor)
        .padding(.horizontal)
    }
    
    private func getDayName(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else { return dateString }
        if Calendar.current.isDateInToday(date) { return "Today" }
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
}

