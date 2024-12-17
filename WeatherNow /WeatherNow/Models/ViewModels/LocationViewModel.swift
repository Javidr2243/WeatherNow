//
//  LocationViewModel.swift
//  Actividad8
//
//  Created by JAVIER DAVILA RUIZ on 17/12/24.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading = false
    
    override init() {
            super.init()
            manager.delegate = self

            // Solicita permiso para usar la ubicación del dispositivo
            manager.requestWhenInUseAuthorization() // O usa requestAlwaysAuthorization() según tu necesidad
        }
        
    

    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        isLoading = false
    }
    
    
   
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location", error)
        isLoading = false
    }
}
