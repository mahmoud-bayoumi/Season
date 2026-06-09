//
//  WeatherIconView.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

import SwiftUI

struct WeatherIconView: View {
    let iconUrlString: String
    
    private var cleanUrl: URL? {
        let correctedPath = iconUrlString.hasPrefix("//") ? "https:\(iconUrlString)" : iconUrlString
        return URL(string: correctedPath)
    }
    
    var body: some View {
        if let url = cleanUrl {
            AsyncImage(url: url) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    Image(systemName: "cloud.sun.fill") 
                        .foregroundColor(.gray)
                case .empty:
                    ProgressView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 48, height: 48)
        } else {
            Image(systemName: "cloud.fill")
                .frame(width: 48, height: 48)
        }
    }
}
