//
//  SavedLocationsView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI
import SwiftData

struct SavedLocationsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \WeatherLocation.timestamp, order: .reverse) private var savedList: [WeatherLocation]
    
    @State private var selectedCityName: String? = nil
    
    var body: some View {
        ZStack {
            backgroundLayer
            
            if savedList.isEmpty {
                SavedLocationsEmptyStateView()
            } else {
                locationsCarouselLayer
            }
        }
        .navigationTitle("Saved Locations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear(perform: setupInitialSelection)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                removeBookmarkButton
            }
        }
    }
    
    
    private var backgroundLayer: some View {
        Image(viewModel.backgroundAsset)
            .resizable()
            .ignoresSafeArea()
    }
    
    private var locationsCarouselLayer: some View {
        TabView(selection: $selectedCityName) {
            ForEach(savedList) { location in
                DetailedWeatherView(
                    city: location.cityName,
                    viewModel: WeatherViewModel(),
                    topPadding: 60
                )
                .tag(location.cityName as String?)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .ignoresSafeArea(edges: .all)
    }
    
    @ViewBuilder
    private var removeBookmarkButton: some View {
        if !savedList.isEmpty {
            Button(action: handleLocationDeletion) {
                Image(systemName: "bookmark.fill")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
    
    
    private func setupInitialSelection() {
        if selectedCityName == nil {
            selectedCityName = savedList.first?.cityName
        }
    }
    
    private func handleLocationDeletion() {
        guard let targetLocation = savedList.first(where: { $0.cityName == selectedCityName }) else { return }
        
        if savedList.count == 1 {
            deleteLocation(targetLocation)
            dismiss()
        } else {
            selectedCityName = savedList.first(where: { $0.cityName != targetLocation.cityName })?.cityName
            deleteLocation(targetLocation)
        }
    }
    
    private func deleteLocation(_ location: WeatherLocation) {
        modelContext.delete(location)
        try? modelContext.save()
    }
}





#Preview {
    let mockVM = WeatherViewModel()
    
    Group {
        NavigationStack {
            SavedLocationsView(viewModel: mockVM)
                .modelContainer(for: WeatherLocation.self, inMemory: true)
        }
    }
}
