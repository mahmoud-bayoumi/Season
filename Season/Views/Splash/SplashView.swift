//
//  SplashScreenView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var animateLogo = false
    @State private var animateText = false
    
    var body: some View {
        ZStack {
            SplashBackgroundView(
                isMorning: viewModel.isMorning,
                backgroundAsset: viewModel.backgroundAsset
            )
            
            VStack {
                Spacer()
                    .frame(height: 150)
                
                SplashLogoGroupView(
                    isMorning: viewModel.isMorning,
                    animateLogo: animateLogo,
                    animateText: animateText
                )
                
                SplashSloganView(
                    isMorning: viewModel.isMorning,
                    animateText: animateText
                )
                
                Spacer()
            }
        }
        .onAppear {
            triggerAnimations()
        }
    }
    
    private func triggerAnimations() {
        withAnimation(.spring(response: 0.9, dampingFraction: 0.7, blendDuration: 0)) {
            animateLogo = true
        }
        
        withAnimation(.easeOut(duration: 0.8).delay(0.3)) {
            animateText = true
        }
    }
}


#Preview {
    SplashScreenView(viewModel: WeatherViewModel())
}
