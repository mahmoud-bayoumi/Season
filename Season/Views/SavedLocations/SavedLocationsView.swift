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
            Image(viewModel.backgroundAsset)
                .resizable()
                .ignoresSafeArea()
            
            if savedList.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bookmark.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.white.opacity(0.8))
                    Text("No locations bookmarked yet.")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            } else {
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
        }
        .navigationTitle("Saved Locations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            if selectedCityName == nil {
                selectedCityName = savedList.first?.cityName
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if !savedList.isEmpty {
                    Button(action: {
                        if let targetLocation = savedList.first(where: { $0.cityName == selectedCityName }) {
                            
                            if savedList.count == 1 {
                                deleteLocation(targetLocation)
                                dismiss()
                            } else {
                                selectedCityName = savedList.first(where: { $0.cityName != targetLocation.cityName })?.cityName
                                deleteLocation(targetLocation)
                            }
                        }
                    }) {
                        Image(systemName: "bookmark.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
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
