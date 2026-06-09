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
    
    var body: some View {
        ZStack {
            // Background Layer
            Image(viewModel.backgroundAsset)
                .resizable()
                .ignoresSafeArea()
            
            // Content Layer
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: viewModel.themeFontColor))
            } else if let weather = viewModel.weather {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 30) {
                        DetailedTopHeaderView(weather: weather, themeColor: viewModel.themeFontColor)
                        
                        DetailedForecastListView(weather: weather, viewModel: viewModel)
                        
                        DetailedMetricsGridView(weather: weather, themeColor: viewModel.themeFontColor)
                    }
                }
            } else if let errorMsg = viewModel.errorMessage {
                Text(errorMsg)
                    .foregroundColor(.red)
                    .padding()
            }
        }
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
        DetailedWeatherView(city: "Cairo", viewModel: mockViewModel)
    }
}
