//
//  UserLocation.swift
//  WeatherApp
//
//  Created by Alberto Huerdo on 6/1/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import Foundation
import CoreLocation


extension Notification.Name {
    
    static let location = "Location"
    
}

protocol UserLocationDelegate: class {
    
    func present(lat: Double, lon: Double)
    func present(errorMessage: String)
}

class UserLocation: NSObject {
    
    //Properties
    weak var delegate: UserLocationDelegate?
    let locationManager = CLLocationManager()
    
    
    func get(delegate: UserLocationDelegate) {        
        self.delegate = delegate
        
        locationManager.delegate = self
        locationManager.activityType = CLActivityType.fitness
        locationManager.distanceFilter = 10   // 10m
        
        // get current location
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
}


extension UserLocation: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else {
            return
        }
        
        locationManager.stopUpdatingLocation()
        delegate?.present(lat: lastLocation.coordinate.latitude, lon: lastLocation.coordinate.longitude)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        var errorMessage = ""
        
        switch status {
        case .authorizedWhenInUse:
            errorMessage = "authorizedWhenInUse"
        case .notDetermined:
            errorMessage = "notDetermined"
        case .restricted:
            errorMessage = "restricted"
        case .denied:
            errorMessage = "denied"
        case .authorizedAlways:
            errorMessage = "authorizedAlways"
        @unknown default:
            errorMessage = "Unknown error while getting the location"
        }
        
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            delegate?.present(errorMessage:errorMessage)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
