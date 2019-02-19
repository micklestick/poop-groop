//
//  LocationManager.swift
//  KnightsMaps
//
//  Created by Alec on 2/14/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import Foundation
import CoreLocation

// This was easiest to make just as an NSObject
// We will want this the be a CLLocationManager
class LocationManager: NSObject {
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var isUpdatingLocation = false
    var lastLocationError: Error?
    
    var parent: ViewController!
    
    // For quickness I just have views the only call back for this class
    // This will change ofcorse
    func findLocation(view: ViewController) {
        
        parent = view
        
        //Request permission
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
            return
        }
       
        // start / stop finding location
        if isUpdatingLocation {
            stopLocationManager()
        }
        else {
            location = nil
            lastLocationError = nil
            startLocationManager()
        }
        
    }
    
    
    
    func startLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            isUpdatingLocation = true
        }
    }
    
    func stopLocationManager() {
        if isUpdatingLocation {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            isUpdatingLocation = false
        }
        
    }


}

extension LocationManager : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("ERROR! locationManager-didFailWithError: \(error)")
        if (error as NSError).code == CLError.locationUnknown.rawValue {
            lastLocationError = error
            stopLocationManager()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        print("Got the location! locationManager-didUpdateLocations: \(String(describing: location))")
        stopLocationManager()
        parent.updateUI(loc: locations.last!)

    }
    
}
