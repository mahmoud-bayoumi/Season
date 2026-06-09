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
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.uppercased())
                .font(.caption2)
                .fontWeight(.bold)
                .foregroundColor(textColor.opacity(0.6))
                .tracking(1) 
            
            Text(value)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
                .padding(.top, 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.08))
        .cornerRadius(12)
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
