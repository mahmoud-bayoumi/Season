//
//  MetricCardView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//


import SwiftUI

struct MetricCardView: View {
    let title: String
    let value: String
    var subtitle: String = ""
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption2)
                .bold()
                .foregroundColor(textColor.opacity(0.6))
            
            Text(value)
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .foregroundColor(textColor)
                
            if !subtitle.isEmpty {
                Text(subtitle)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(textColor.opacity(0.8))
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.top, 2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.all, 14)
        .background(Color.white.opacity(0.06))
        .cornerRadius(16)
    }
}

#Preview {
    ZStack {
        Color.black.opacity(0.9).ignoresSafeArea()
        HStack {
            MetricCardView(title: "Visibility", value: "10 km", textColor: .white)
            MetricCardView(title: "Humidity", value: "36%", textColor: .white)
        }
        .padding()
    }
}
