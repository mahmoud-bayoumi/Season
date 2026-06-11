//
//  ForecastRowView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI

struct ForecastRowView: View {
    let forecastDay: ForecastDay
    let textColor: Color
    
    var body: some View {
        HStack {
            Text(getDayName(from: forecastDay.date))
                .font(.body)
                .fontWeight(.medium)
                .frame(width: 90, alignment: .leading)
            
            Spacer()
            
            WeatherIconView(iconUrlString: forecastDay.day.condition.icon)
                .frame(width: 35, height: 35)
            
            Spacer()
            
            Text("\(Int(forecastDay.day.mintempC))° - \(Int(forecastDay.day.maxtempC))°")
                .font(.body)
                .monospacedDigit()
                .frame(width: 100, alignment: .trailing)
        }
        .foregroundColor(textColor)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(Color.white.opacity(0.08))
        .cornerRadius(12)
    }
    
    private func getDayName(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = formatter.date(from: dateString) else { return dateString }
        
        if Calendar.current.isDateInToday(date) {
            return "Today"
        }
        
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
}

//#Preview {
//    ZStack {
//        Color.blue.ignoresSafeArea()
//        VStack {
//            if let sampleDay = WeatherResponse.mockPreviewData.forecast.forecastday.first {
//                ForecastRowView(forecastDay: sampleDay, textColor: .white)
//            }
//        }
//        .padding()
//    }
//}
