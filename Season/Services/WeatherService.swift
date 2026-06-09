//
//  WeatherService.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//


import Foundation

class WeatherService {
    private let apiKey = Secrets.weatherAPIKey
    
    private let customSession: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 6.0 
        config.timeoutIntervalForResource = 6.0
        return URLSession(configuration: config)
    }()

    func fetchWeather(for query: String) async throws -> WeatherResponse {
        // Formats queries (safely structures raw inputs like "30.0715495,31.0215953")
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(encodedQuery)&days=3&aqi=yes&alerts=no") else {
            throw URLError(.badURL)
        }

        print("Executing Weather API Web Request: \(url.absoluteString)")

        // Utilizes custom timeout configuration session instead of shared instances
        let (data, response) = try await customSession.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        print("API Gateway answered with status code: \(httpResponse.statusCode)")

        guard httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
