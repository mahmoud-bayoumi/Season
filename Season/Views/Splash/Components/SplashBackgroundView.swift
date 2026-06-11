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
    
                Image(backgroundAsset)
                    .resizable()
                    .ignoresSafeArea()
            
            
            Color.black.opacity(isMorning ? 0.0 : 0.25)
                .ignoresSafeArea()
        }
    }
}

#Preview {
    SplashBackgroundView(isMorning: true, backgroundAsset: "")
}
