//
//  HomeAstroPanelView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI

struct AstroPanelView: View {
    let astro: Astro
    let themeColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 4) {
                Text("SUNRISE")
                    .font(.caption)
                    .bold()
                    .foregroundColor(themeColor.opacity(0.6))
                Text(astro.sunrise)
                    .font(.headline)
                    .foregroundColor(themeColor)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("SUNSET")
                    .font(.caption)
                    .bold()
                    .foregroundColor(themeColor.opacity(0.6))
                Text(astro.sunset)
                    .font(.headline)
                    .foregroundColor(themeColor)
            }
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }
}


