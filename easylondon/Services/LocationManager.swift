//
//  LocationManager.swift
//  easylondon
//
//  Created by Saugat Poudel on 08/07/2024.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
    private let locationManager = CLLocationManager()
    @Published var location:CLLocation? = nil
    @Published var authorisationStatus: CLAuthorizationStatus = .notDetermined
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        requestAuthorisation()
    }
    
    func requestAuthorisation(){
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation(){
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation(){
        locationManager.stopUpdatingLocation()
    }
    
    // CLLocationManagerDelegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorisationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        
        print("Cannot get location: \(error.localizedDescription)")
    }
    
}
