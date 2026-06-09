//
//  LocationManager.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//


import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var fallbackTimer: Timer?
    
    @Published var locationString: String?
    @Published var isSearchingGPS: Bool = true
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }
    
    func requestLocationPermission() {
        let status = manager.authorizationStatus
        
        print("Current Location Permission Status: \(status.rawValue)")
        
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            startFallbackTimer()
            manager.requestLocation()
        case .denied, .restricted:
            triggerFallback(reason: "Permission Explicitly Denied")
        @unknown default:
            triggerFallback(reason: "Unknown Status Code")
        }
    }
    
    // This delegate method automatically runs the moment the user clicks "Allow" or "Don't Allow"
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        print("Authorization status updated to: \(status.rawValue)")
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startFallbackTimer()
            manager.requestLocation()
        case .denied, .restricted:
            triggerFallback(reason: "User tapped Deny")
        case .notDetermined:
            break
        @unknown default:
            triggerFallback(reason: "Unknown status update")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        invalidateTimer()
        guard let location = locations.first else {
            triggerFallback(reason: "Empty coordinate bundle")
            return
        }
        
        DispatchQueue.main.async {
            self.locationString = "\(location.coordinate.latitude),\(location.coordinate.longitude)"
            self.isSearchingGPS = false
            print("Successfully pinpointed device coordinates: \(self.locationString ?? "")")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Hardware tracking error: \(error.localizedDescription)")
        if let clError = error as? CLError, clError.code != .locationUnknown {
            invalidateTimer()
            triggerFallback(reason: error.localizedDescription)
        }
    }
    
    private func startFallbackTimer() {
        invalidateTimer()
        fallbackTimer = Timer.scheduledTimer(withTimeInterval: 3.5, repeats: false) { [weak self] _ in
            self?.triggerFallback(reason: "GPS hardware search timeout")
        }
    }
    
    private func invalidateTimer() {
        fallbackTimer?.invalidate()
        fallbackTimer = nil
    }
    
    private func triggerFallback(reason: String) {
        print("Activating backup system path: \(reason)")
        DispatchQueue.main.async {
            if self.locationString == nil {
                self.locationString = "Cairo" // Loads Cairo by default if GPS isn't ready
            }
            self.isSearchingGPS = false
        }
    }
}
