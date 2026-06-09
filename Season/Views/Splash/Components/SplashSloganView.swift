//
//  SplashSloganView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct SplashSloganView: View {
    let isMorning: Bool
    let animateText: Bool
    
    var body: some View {
        Text("BEYOND THE FORECAST")
            .font(.system(size: 11, weight: .medium))
            .foregroundColor((isMorning ? Color.black : Color.white).opacity(0.5))
            .tracking(4)
            .opacity(animateText ? 1.0 : 0.0)
            .padding(.bottom, 30)
    }
}

#Preview {
    SplashSloganView(isMorning: true, animateText: true)
}
