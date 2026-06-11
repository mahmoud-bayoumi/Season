//
//  WeatherBackgroundView.swift
//  Season
//
//  Created by Bayoumi on 11/06/2026.
//

import SwiftUI


struct WeatherBackgroundView: View {
    let isMorning: Bool
    let assetName: String
    
    var body: some View {
        if isMorning {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.45, green: 0.69, blue: 0.95),
                    Color(red: 0.68, green: 0.85, blue: 0.98)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        } else {
            Image(assetName)
                .resizable()
                .ignoresSafeArea()
        }
    }
}

