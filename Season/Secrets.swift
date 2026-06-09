//
//  Secrets.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import Foundation

enum Secrets {
    static var weatherAPIKey: String {
        guard
            let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path),
            let key = dict["WEATHER_API_KEY"] as? String
        else {
            fatalError("Missing WEATHER_API_KEY in Secrets.plist")
        }

        return key
    }
}
