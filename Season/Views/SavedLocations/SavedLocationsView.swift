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
    
    var body: some View {
        ZStack {
            Image(viewModel.backgroundAsset)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                if savedList.isEmpty {
                    Text("No locations bookmarked yet.")
                        .font(.subheadline)
                        .foregroundColor(viewModel.themeFontColor.opacity(0.6))
                        .padding(.top, 40)
                    Spacer()
                } else {
                    List {
                        ForEach(savedList) { location in
                            Button(action: {
                                Task {
                                    await viewModel.loadWeather(for: location.cityName)
                                    dismiss()
                                }
                            }) {
                                HStack {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.title3)
                                        .foregroundColor(viewModel.themeFontColor.opacity(0.8))
                                    
                                    Text(location.cityName)
                                        .font(.headline)
                                        .fontWeight(.medium)
                                        .foregroundColor(viewModel.themeFontColor)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.subheadline)
                                        .foregroundColor(viewModel.themeFontColor.opacity(0.5))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .listRowBackground(Color.white.opacity(0.08))
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteLocation)
                    }
                    .scrollContentBackground(.hidden)
                }
            }
            .padding(.top, 15)
        }
        .navigationTitle("Saved Locations")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(viewModel.isMorning ? .dark : .dark, for: .navigationBar)
    }
    
    private func deleteLocation(at offsets: IndexSet) {
        for index in offsets {
            let targetRecord = savedList[index]
            modelContext.delete(targetRecord)
        }
        try? modelContext.save()
    }
}

#Preview {
    let mockVM = WeatherViewModel()
    
    Group {
        NavigationView {
            SavedLocationsView(viewModel: mockVM)
                .modelContainer(for: WeatherLocation.self, inMemory: true)
        }
    }
}
