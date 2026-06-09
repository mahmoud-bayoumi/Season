//
//  DetailedWeatherView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI

struct DetailedWeatherView: View {
    let city: String
    @StateObject var viewModel: WeatherViewModel
    @State private var selectedDay: ForecastDay? = nil
    
    var body: some View {
        ZStack {
 
            Image(viewModel.backgroundAsset)
                    .resizable()
                    .ignoresSafeArea()
            
            
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: viewModel.themeFontColor))
            } else if let weather = viewModel.weather {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        
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
                        .foregroundColor(viewModel.themeFontColor)
                        .padding(.top, 20)
                        
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
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            MetricCard(title: "VISIBILITY", value: "\(Int(weather.current.visKm)) km", textColor: viewModel.themeFontColor)
                            MetricCard(title: "HUMIDITY", value: "\(weather.current.humidity)%", textColor: viewModel.themeFontColor)
                            MetricCard(title: "FEELS LIKE", value: "\(Int(weather.current.feelslikeC))°", textColor: viewModel.themeFontColor)
                            MetricCard(title: "PRESSURE", value: String(format: "%.0f mb", weather.current.pressureMb), textColor: viewModel.themeFontColor)
                        }
                        .padding(.horizontal)
                    }
                }
            } else if let errorMsg = viewModel.errorMessage {
                Text(errorMsg).foregroundColor(.red).padding()
            }
        }
        .task {
            await viewModel.loadWeather(for: city)
        }
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



#Preview {
    let mockViewModel: WeatherViewModel = {
        let vm = WeatherViewModel()
        vm.weather = WeatherResponse.mockPreviewData
        return vm
    }()
    
    NavigationView {
        DetailedWeatherView(city: "Cairo", viewModel: mockViewModel)
    }
}
