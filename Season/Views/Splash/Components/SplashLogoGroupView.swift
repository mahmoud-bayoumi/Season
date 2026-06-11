//
//  SplashLogoGroupView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct SplashLogoGroupView: View {
    let isMorning: Bool
    let animateLogo: Bool
    let animateText: Bool
    
    var body: some View {
        VStack(spacing: -100) {
            Image("app_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 400)
                .shadow(color: Color.black.opacity(0.12), radius: 25, x: 0, y: 12)
                .scaleEffect(animateLogo ? 1.0 : 0.8)
                .opacity(animateLogo ? 1.0 : 0.0)

            Text("SEASON")
                .font(.system(size: 38, weight: .bold))
                .foregroundColor(isMorning ? .white : .white)
                .tracking(10)
                .opacity(animateText ? 1.0 : 0.0)
                .offset(y: animateText ? 0 : 15)
        }
        .padding(.bottom , 20)
    }
}

#Preview {
    SplashLogoGroupView(isMorning: true, animateLogo: true, animateText: true)
}
