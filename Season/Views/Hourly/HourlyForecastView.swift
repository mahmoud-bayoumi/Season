//
//  HourlyForecastView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//


import SwiftUI

struct HourlyForecastView: View {
    let forecastDay: ForecastDay
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            Image(viewModel.backgroundAsset)
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text("Hourly Trends")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(viewModel.themeFontColor)
                    .padding([.top, .horizontal])
                
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(Array(forecastDay.hour.enumerated()), id: \.element.id) { index, hour in
                            HStack {
                                Text(index == 0 ? "Now" : parseTimestamp(hour.time))
                                    .font(.title3)
                                    .frame(width: 90, alignment: .leading)
                                
                                Spacer()
                                
                                WeatherIconView(iconUrlString: hour.condition.icon)
                                    .frame(width: 40, height: 40)
                                
                                Spacer()
                                
                                Text("\(Int(hour.tempC))°")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .frame(width: 60, alignment: .trailing)
                            }
                            .foregroundColor(viewModel.themeFontColor)
                            .padding()
                            .background(Color.white.opacity(0.06))
                            .cornerRadius(12)
                        }
                    }
                    .padding()
                }
            }
        }
    }
    
    private func parseTimestamp(_ timestamp: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = inputFormatter.date(from: timestamp) else { return timestamp }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h a" 
        return outputFormatter.string(from: date)
    }
}
