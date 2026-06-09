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
    // Single shared source of truth injected into structural view hierarchies
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showSplashScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if showSplashScreen {
                    SplashScreenView(viewModel: viewModel)
                        .transition(.opacity)
                } else {
                   
                    ContentView()
                }
            }
            .modelContainer(for: WeatherLocation.self)
            .onAppear {
                // Holds splash presentation, then executes cross-fade transition
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                    withAnimation(.easeInOut(duration: 0.45)) {
                        showSplashScreen = false
                    }
                }
            }
        }
    }
}
