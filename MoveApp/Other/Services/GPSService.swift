//
//  GPSService.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 26/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import CoreLocation

class GPSService: NSObject, CLLocationManagerDelegate {
    
    private var locationManager: CLLocationManager
    private var userLocationCompletion: CompletionLocation?
    
     override init() {
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getUserLocation(completion: @escaping CompletionLocation) {
        userLocationCompletion = completion
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let newLocation = locations.last {
            locationManager.stopUpdatingLocation()
            let userLocation = Location(latitude: newLocation.coordinate.latitude,
                                       longitude: newLocation.coordinate.longitude)
            userLocationCompletion?(userLocation)
        }
    }
}
