//
//  SeasonApp.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI
import SwiftData

@main
struct SeasonApp: App {
    @State private var showSplashScreen = true
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplashScreen {
                    SplashScreenView()
                        .transition(.opacity)
                }else {
                    ContentView()
                }
            }
            .modelContainer(for: WeatherLocation.self)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        showSplashScreen = false
                    }
                }
            }
                
            
        }
    }
}
