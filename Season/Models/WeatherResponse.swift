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
    
    let uv: Double
    let windKph: Double
    let windDir: String
    
    let gustKph: Double
    let precipMm: Double
    let airQuality: AirQuality?
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case feelslikeC = "feelslike_c"
        case condition, humidity, uv
        case visKm = "vis_km"
        case pressureMb = "pressure_mb"
        case isDay = "is_day"
        case windKph = "wind_kph"
        case windDir = "wind_dir"
        case gustKph = "gust_kph"
        case precipMm = "precip_mm"
        case airQuality = "air_quality"
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
    
    let astro: Astro
    let hour: [Hour]
}

struct DayInfo: Codable {
    let maxtempC: Double
    let mintempC: Double
    let condition: WeatherCondition
    
    let dailyChanceOfRain: Int
    let totalprecipMm: Double
    
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
        case dailyChanceOfRain = "daily_chance_of_rain"
        case totalprecipMm = "totalprecip_mm"
    }
}

struct Astro: Codable {
    let sunrise: String
    let sunset: String
    let moonPhase: String?
    
    enum CodingKeys: String, CodingKey {
        case sunrise, sunset
        case moonPhase = "moon_phase"
    }
}

struct Hour: Codable, Identifiable {
    let timeEpoch: Int
    let time: String
    let tempC: Double
    let condition: WeatherCondition
    
    var id: Int { timeEpoch }
    
    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time, condition
        case tempC = "temp_c"
    }
}

typealias HourInfo = Hour

struct AirQuality: Codable {
    let pm25: Double
    let pm10: Double
    let epaIndex: Int
    
    enum CodingKeys: String, CodingKey {
        case pm25 = "pm2_5"
        case pm10 = "pm10"
        case epaIndex = "us-epa-index"
    }
}
