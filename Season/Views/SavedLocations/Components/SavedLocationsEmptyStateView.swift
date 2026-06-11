//
//  SavedLocationsEmptyStateView.swift
//  Season
//
//  Created by Bayoumi on 09/06/2026.
//

import SwiftUI

struct SavedLocationsEmptyStateView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "bookmark.slash")
                .font(.system(size: 50))
                .foregroundColor(.white.opacity(0.8))
            Text("No locations bookmarked yet.")
                .font(.headline)
                .foregroundColor(.white)
        }
    }
}

#Preview {
    SavedLocationsEmptyStateView()
}
