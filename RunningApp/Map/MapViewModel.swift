//
//  MapViewModel.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/28/22.
//

import MapKit
import SwiftUI

enum MapDetails {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Show an alert letting them know this is off and tell them to turn it on.") // TODO: handle this case
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
            print("Your location is restricted.") // TODO: handle this case
            case .denied:
                print("You have denied this app location permission. Go into settings to change it.") // TODO: handle this case
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = locationManager.location {
                    region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
                }
            @unknown default:
                break
        }
    }
}
