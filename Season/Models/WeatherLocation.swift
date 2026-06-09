//
//  WeatherLocation.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//



import Foundation
import SwiftData

@Model
class WeatherLocation {
    @Attribute(.unique) var cityName: String
    var timestamp: Date
    
    init(cityName: String, timestamp: Date = Date()) {
        self.cityName = cityName
        self.timestamp = timestamp
    }
}
