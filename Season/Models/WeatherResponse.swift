//
//  WeatherResponse.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//


import Foundation

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
    let forecast: Forecast
}

struct Location: Codable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
}

struct CurrentWeather: Codable {
    let tempC: Double
    let feelslikeC: Double
    let condition: WeatherCondition
    let humidity: Int
    let visKm: Double
    let pressureMb: Double
    let isDay: Int
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case condition, humidity
        case visKm = "vis_km"
        case pressureMb = "pressure_mb"
        case isDay = "is_day"
    }
}

struct WeatherCondition: Codable {
    let text: String
    let icon: String
}

struct Forecast: Codable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Identifiable {
    var id: String { date }
    let date: String
    let day: DayInfo
    let hour: [HourInfo]
}

struct DayInfo: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}

struct HourInfo: Codable, Identifiable {
    var id: String { time }
    let time: String
    let tempC: Double
    let condition: WeatherCondition
    
    enum CodingKeys: String, CodingKey {
        case time, condition
        case tempC = "temp_c"
    }
}
