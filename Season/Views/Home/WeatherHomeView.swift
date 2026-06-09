//
//  WeatherHomeView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI
import SwiftData

struct WeatherHomeView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject private var locationManager = LocationManager()
    @Environment(\.modelContext) private var modelContext
    
    @State private var bookmarkToggleTrigger = false
    @FocusState private var isSearchFieldFocused: Bool
    
    // Routing state for programmatic navigation
    @State private var navigateToDetailedCity = false
    @State private var selectedSearchCity = ""
    
    var body: some View {
        NavigationView {
            ZStack {
 
            Image(viewModel.backgroundAsset)
                        .resizable()
                        .ignoresSafeArea()
                
                
                // Hidden Navigation Router
                NavigationLink(
                    destination: DetailedWeatherView(city: selectedSearchCity, viewModel: WeatherViewModel()),
                    isActive: $navigateToDetailedCity,
                    label: { EmptyView() }
                )
                
                VStack(spacing: 0) {
                    customThemeSearchBar
                    
                    if let weather = viewModel.weather {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 28) {
                                
                                // --- DIVISION 1: TOP PANEL ---
                                VStack(spacing: 4) {
                                    Text(weather.location.name)
                                        .font(.system(size: 34, weight: .medium))
                                    Text("\(Int(weather.current.tempC))°")
                                        .font(.system(size: 76, weight: .thin))
                                    Text(weather.current.condition.text)
                                        .font(.title3)
                                        .fontWeight(.light)
                                    if let today = weather.forecast.forecastday.first {
                                        Text("H:\(Int(today.day.maxtempC))° L:\(Int(today.day.mintempC))°")
                                            .font(.subheadline)
                                    }
                                    WeatherIconView(iconUrlString: weather.current.condition.icon)
                                        .frame(width: 50, height: 50)
                                }
                                .foregroundColor(viewModel.themeFontColor)
                                .padding(.top, 10)
                                
                                // --- DIVISION 2: MIDDLE PANEL (3-DAY FORECAST) ---
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("3-DAY FORECAST")
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(viewModel.themeFontColor.opacity(0.6))
                                        .padding(.horizontal, 4)
                                    
                                    Divider().background(viewModel.themeFontColor.opacity(0.3))
                                    
                                    ForEach(weather.forecast.forecastday) { day in
                                        NavigationLink(destination: HourlyForecastView(forecastDay: day, viewModel: viewModel)) {
                                            ForecastRowView(forecastDay: day, textColor: viewModel.themeFontColor)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.05))
                                .cornerRadius(16)
                                
                                // --- DIVISION 3: BOTTOM PANEL (METRIC GRID) ---
                                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                                    MetricCardView(title: "Visibility", value: "\(Int(weather.current.visKm)) km", textColor: viewModel.themeFontColor)
                                    MetricCardView(title: "Humidity", value: "\(weather.current.humidity)%", textColor: viewModel.themeFontColor)
                                    MetricCardView(title: "Feels Like", value: "\(Int(weather.current.feelslikeC))°", textColor: viewModel.themeFontColor)
                                    MetricCardView(title: "Pressure", value: String(format: "%.0f mb", weather.current.pressureMb), textColor: viewModel.themeFontColor)
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else if locationManager.isSearchingGPS || viewModel.isLoading {
                        Spacer()
                        ProgressView("Acquiring local forecast data...")
                            .progressViewStyle(CircularProgressViewStyle(tint: viewModel.themeFontColor))
                            .foregroundColor(viewModel.themeFontColor)
                        Spacer()
                    } else if let errorMsg = viewModel.errorMessage {
                        Spacer()
                        Text(errorMsg).foregroundColor(.red).padding()
                        Spacer()
                    }
                }
            }
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
    
    // Custom Stylized Frosted Search Component Block
    private var customThemeSearchBar: some View {
        HStack(spacing: 14) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(viewModel.themeFontColor.opacity(0.6))
                    .padding(.leading, 12)
                
                TextField("", text: $viewModel.searchText, prompt:
                    Text("Search globally...")
                        .foregroundColor(viewModel.themeFontColor.opacity(0.5))
                )
                .font(.body)
                .foregroundColor(viewModel.themeFontColor)
                .focused($isSearchFieldFocused)
                .submitLabel(.search)
                .onSubmit {
                    if !viewModel.searchText.isEmpty {
                        // Triggers the detailed view transition
                        selectedSearchCity = viewModel.searchText
                        navigateToDetailedCity = true
                        
                        // Clears field for when user returns
                        viewModel.searchText = ""
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

#Preview {
    WeatherHomeView()
}
