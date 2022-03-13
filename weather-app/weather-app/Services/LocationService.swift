//
//  LocationService.swift
//  weather-app
//
//  Created by admin on 26.02.22.
//

import UIKit
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    static var instance = LocationService()
    
    var currentLocation: CLLocation?

    private override init() {
        super.init()
        
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
