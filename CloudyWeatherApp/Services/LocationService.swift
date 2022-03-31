//
//  LocationService.swift
//  CloudyWeatherApp
//
//  Created by Carleton C Snow III on 2/19/22.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    static let shared = LocationService()
    
    var locationManager: CLLocationManager?
    
    func getLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied:
            print("denied")
        case .notDetermined:
            print("notDetermined")
        case .authorizedWhenInUse:
            print("inUse")
            locationManager?.requestLocation()
        case .authorizedAlways:
            print("Always")
            locationManager?.requestLocation()
        case .restricted:
            print("restricted")
        default:
            print("didChangeAuthorization")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let first = locations.first else {
            return
        }
        DataService.instance.lon = first.coordinate.longitude
        DataService.instance.lat = first.coordinate.latitude
        
        DataService.instance.getWeather()
        DataService.instance.getCityName()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
            locationManager?.stopMonitoringSignificantLocationChanges()
            return
        }
    }
}


