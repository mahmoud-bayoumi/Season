//
//  HomeAirQualityView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI

struct AirQualityView: View {
    let aqi: AirQuality
    let themeColor: Color
    
    private var status: (text: String, color: Color) {
        switch aqi.epaIndex {
        case 1:  return ("Good", .green)
        case 2:  return ("Moderate", .yellow)
        case 3:  return ("Unhealthy for Sensitive Groups", .orange)
        case 4:  return ("Unhealthy", .red)
        default: return ("Very Unhealthy", .purple)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "aqi.low")
                Text("AIR QUALITY")
            }
            .font(.caption)
            .bold()
            .foregroundColor(themeColor.opacity(0.6))
            
            Text("\(status.text) — PM2.5 is \(Int(aqi.pm25)) µg/m³")
                .font(.callout)
                .bold()
                .foregroundColor(themeColor)
            
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(LinearGradient(
                            colors: [.green, .yellow, .orange, .red, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .frame(height: 6)
                    
                    Circle()
                        .fill(themeColor)
                        .frame(width: 12, height: 12)
                        .shadow(radius: 2)
                        .offset(x: calculatedPosition(totalWidth: geo.size.width))
                }
            }
            .frame(height: 12)
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
    
    private func calculatedPosition(totalWidth: CGFloat) -> CGFloat {
        let normalizedIndex = CGFloat(clamp(aqi.epaIndex, min: 1, max: 5) - 1)
        return (normalizedIndex / 4.0) * (totalWidth - 12)
    }
    
    private func clamp(_ value: Int, min minValue: Int, max maxValue: Int) -> Int {
        return min(max(value, minValue), maxValue)
    }
}

