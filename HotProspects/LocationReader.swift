//
//  LocationReader.swift
//  HotProspects
//
//  Created by Deye Lei on 1/9/23.
//

import Foundation
import CoreLocation

class LocationReader: NSObject, CLLocationManagerDelegate, ObservableObject{
    let manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    
    override init(){
        super.init()
        manager.delegate = self
    }
    
    func getStatus()->CLAuthorizationStatus{
        return manager.authorizationStatus
    }
    
    func requestLocation(){
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
    }
}
