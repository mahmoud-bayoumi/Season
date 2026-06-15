//
//  WeatherViewModel.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//



import SwiftUI
import SwiftData
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService()
    
    var isMorning: Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 5 && hour < 18
    }
    
    var themeFontColor: Color {
        isMorning ? .white : .white
    }
    
    var backgroundAsset: String {
        isMorning ? "morning_bg4" : "evening_bg3"
    }
    
    func loadWeather(for coordinateOrCity: String) async {
        isLoading = true
        errorMessage = nil
        
        defer { isLoading = false }
        
        do {
            self.weather = try await weatherService.fetchWeather(for: coordinateOrCity)
        } catch {
            self.errorMessage = "Unable to fetch data: \(error.localizedDescription)"
        }
    }
    
    // SwiftData Operations
    
    /// Checks if the currently active city is already saved in the database
    func isCurrentLocationSaved(context: ModelContext) -> Bool {
        guard let currentCity = weather?.location.name else { return false }
        
        let descriptor = FetchDescriptor<WeatherLocation>(
            predicate: #Predicate { $0.cityName == currentCity }
        )
        let count = (try? context.fetchCount(descriptor)) ?? 0
        return count > 0
    }
    
    /// Toggles bookmark state: Saves if new, Unsaves (Deletes) if already present
    func toggleBookmark(context: ModelContext) {
        guard let currentCity = weather?.location.name, !currentCity.isEmpty else { return }
        
        let descriptor = FetchDescriptor<WeatherLocation>(
            predicate: #Predicate { $0.cityName == currentCity }
        )
        
        if let matchingLocations = try? context.fetch(descriptor), let existing = matchingLocations.first {
            // Delete from SwiftData if Loction exists
            context.delete(existing)
            print("Successfully unsaved: \(currentCity)")
        } else {
            // Save it if location dosen't exists
            let newLocation = WeatherLocation(cityName: currentCity)
            context.insert(newLocation)
            print("Successfully saved: \(currentCity)")
        }
        
        try? context.save()
    }
}
