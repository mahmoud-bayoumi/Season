//
//  WeatherHomeView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI
import SwiftData
import Charts 

struct WeatherHomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    @Environment(\.modelContext) private var modelContext
    
    @State private var bookmarkToggleTrigger = false
    @FocusState private var isSearchFieldFocused: Bool
    
    @State private var isRefreshing = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                HomeBackgroundView(isMorning: viewModel.isMorning, assetName: viewModel.backgroundAsset)
                
                VStack(spacing: 0) {
                    customThemeSearchBar
                    
                    if let weather = viewModel.weather {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 28) {
                                HomeTopPanelView(weather: weather, themeColor: viewModel.themeFontColor)
                                
                                if let aqi = weather.current.airQuality {
                                    AirQualityView(aqi: aqi, themeColor: viewModel.themeFontColor)
                                }
                                
                                if let today = weather.forecast.forecastday.first {
                                    HourlyChartView(hours: today.hour, themeColor: viewModel.themeFontColor)
                                }
                                
                                HomeForecastListView(weather: weather, viewModel: viewModel)
                                
                                MetricsGridView(weather: weather, themeColor: viewModel.themeFontColor)
                                
                                if let astro = weather.forecast.forecastday.first?.astro {
                                    AstroPanelView(astro: astro, themeColor: viewModel.themeFontColor)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 40)
                        }
                        .refreshable {
                            isRefreshing = true
                            
                            if let currentCity = viewModel.weather?.location.name {
                                await viewModel.loadWeather(for: currentCity)
                            } else if let coordinates = locationManager.locationString {
                                await viewModel.loadWeather(for: coordinates)
                            }
                            
                            try? await Task.sleep(nanoseconds: 500_000_000)
                            isRefreshing = false
                        }
                    } else if locationManager.isSearchingGPS || viewModel.isLoading {
                        Spacer()
                        ProgressView("Acquiring local forecast data...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .foregroundColor(.white)
                        Spacer()
                    } else if let errorMsg = viewModel.errorMessage {
                        Spacer()
                        Text(errorMsg).foregroundColor(.red).padding()
                        Spacer()
                    }
                }
                
                if isRefreshing {
                    VStack {
                        HStack(spacing: 12) {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            Text("Updating...")
                                .font(.subheadline.bold())
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color.white.opacity(viewModel.isMorning ? 0.3 : 0.15))
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                        .shadow(color: Color.black.opacity(0.15), radius: 10, y: 5)
                        .padding(.top, 70)
                        
                        Spacer()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale(scale: 0.9)))
                    .zIndex(10)
                }
            }
            .animation(.spring(response: 0.4, dampingFraction: 0.65), value: isRefreshing)
            .navigationBarHidden(true)
        }
        .onAppear {
            locationManager.requestLocationPermission()
            bookmarkToggleTrigger.toggle()
        }
        .task(id: locationManager.locationString) {
            if let coordinates = locationManager.locationString {
                await viewModel.loadWeather(for: coordinates)
                bookmarkToggleTrigger.toggle()
            }
        }
    }
    
    private var customThemeSearchBar: some View {
        HStack(spacing: 14) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(viewModel.themeFontColor.opacity(0.6))
                    .padding(.leading, 12)
                
                ZStack(alignment: .leading) {
                    if viewModel.searchText.isEmpty {
                        Text("Search globally...")
                            .font(.body)
                            .foregroundColor(viewModel.isMorning ? viewModel.themeFontColor.opacity(0.6) : Color(uiColor: .lightGray))
                    }
                    
                    TextField("", text: $viewModel.searchText)
                        .font(.body)
                        .foregroundColor(viewModel.themeFontColor)
                        .focused($isSearchFieldFocused)
                        .submitLabel(.search)
                        .onSubmit {
                            if !viewModel.searchText.isEmpty {
                                Task {
                                    await viewModel.loadWeather(for: viewModel.searchText)
                                    bookmarkToggleTrigger.toggle()
                                    
                                    viewModel.searchText = ""
                                    isSearchFieldFocused = false
                                }
                            }
                        }
                }
                
                if !viewModel.searchText.isEmpty {
                    Button(action: { viewModel.searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(viewModel.themeFontColor.opacity(0.6))
                            .padding(.trailing, 12)
                    }
                }
            }
            .frame(height: 44)
            .background(Color.white.opacity(viewModel.isMorning ? 0.25 : 0.12))
            .cornerRadius(22)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(viewModel.themeFontColor.opacity(isSearchFieldFocused ? 0.5 : 0.15), lineWidth: 1.5)
            )
            .animation(.easeInOut(duration: 0.2), value: isSearchFieldFocused)
            
            if viewModel.weather != nil {
                Button(action: {
                    viewModel.toggleBookmark(context: modelContext)
                    bookmarkToggleTrigger.toggle()
                }) {
                    Image(systemName: viewModel.isCurrentLocationSaved(context: modelContext) ? "bookmark.fill" : "bookmark")
                        .font(.title2)
                        .foregroundColor(viewModel.themeFontColor)
                        .id(bookmarkToggleTrigger)
                }
            }
            
            NavigationLink(destination: SavedLocationsView(viewModel: viewModel)) {
                Image(systemName: "list.bullet")
                    .font(.title2)
                    .foregroundColor(viewModel.themeFontColor)
            }
        }
        .padding(.horizontal)
        .padding(.top, 12)
        .padding(.bottom, 6)
    }
}

