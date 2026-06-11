//
//  DetailedWeatherView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI
import SwiftData
import Charts 

struct DetailedWeatherView: View {
    let city: String
    @StateObject var viewModel: WeatherViewModel
    
    var topPadding: CGFloat = 0
    
    @State private var isRefreshing = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else if let weather = viewModel.weather {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        DetailedTopHeaderView(weather: weather, themeColor: viewModel.themeFontColor)
                        
                        if let aqi = weather.current.airQuality {
                            AirQualityView(aqi: aqi, themeColor: viewModel.themeFontColor)
                        }
                        
                        if let today = weather.forecast.forecastday.first {
                            HourlyChartView(hours: today.hour, themeColor: viewModel.themeFontColor)
                        }
                        
                        DetailedForecastListView(weather: weather, viewModel: viewModel)
                        
                        MetricsGridView(weather: weather, themeColor: viewModel.themeFontColor)
                        
                        if let astro = weather.forecast.forecastday.first?.astro {
                            AstroPanelView(astro: astro, themeColor: viewModel.themeFontColor)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, topPadding)
                    .padding(.bottom, 40)
                }
                .refreshable {
                    isRefreshing = true
                    
                    await viewModel.loadWeather(for: city)
                    
                    try? await Task.sleep(nanoseconds: 500_000_000)
                    isRefreshing = false
                }
            } else if let errorMsg = viewModel.errorMessage {
                Text(errorMsg)
                    .foregroundColor(.red)
                    .padding()
            }
            
            if isRefreshing {
                VStack {
                    HStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Updating...")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white.opacity(viewModel.isMorning ? 0.3 : 0.15))
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.15), radius: 10, y: 5)
                    .padding(.top, topPadding + 10)
                    
                    Spacer()
                }
                .transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale(scale: 0.9)))
                .zIndex(10)
            }
        }
        .animation(.spring(response: 0.4, dampingFraction: 0.65), value: isRefreshing)
        .task {
            await viewModel.loadWeather(for: city)
        }
    }
}

#Preview {
    let mockViewModel: WeatherViewModel = {
        let vm = WeatherViewModel()
        vm.weather = WeatherResponse.mockPreviewData
        return vm
    }()
    
    NavigationView {
        DetailedWeatherView(city: "`Izbat Yusif Barradah", viewModel: mockViewModel)
    }
}
