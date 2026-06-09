//
//  MetricCard.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct MetricCard: View {
    let title: String
    let value: String
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(textColor.opacity(0.6))
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(12)
    }
}


#Preview {
    MetricCard(title: "Cairo", value: "20", textColor: .white)
}
