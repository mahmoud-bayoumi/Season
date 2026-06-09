//
//  SplashBackgroundView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct SplashBackgroundView: View {
    let isMorning: Bool
    let backgroundAsset: String
    
    var body: some View {
        ZStack {
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
                Image(backgroundAsset)
                    .resizable()
                    .ignoresSafeArea()
            }
            
            // Subtle darkening overlay
            Color.black.opacity(isMorning ? 0.0 : 0.25)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashBackgroundView(isMorning: true, backgroundAsset: "")
}
