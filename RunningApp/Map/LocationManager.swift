//
//  LocationManager.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/10/22.
//

import CoreLocation
import MapKit

enum MapDetails {
    static let defaultLocation = CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpan)
    @Published var location: CLLocationCoordinate2D = MapDetails.defaultLocation
    @Published var speed: Double

    override init() {
        self.speed = 0
        super.init()
        locManager.delegate = self
        locManager.activityType = CLActivityType.fitness
        locManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        locManager.requestLocation()
    }
    
    func requestUpdatingLocation() {
        locManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            location = locations.first!.coordinate
            speed = locations.first!.speed
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error requesting location: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch locManager.authorizationStatus {
            
            case .notDetermined:
                locManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Your location is restricted.") // TODO: handle this case
            case .denied:
                print("You have denied this app location permission. Go into settings to change it.") // TODO: handle this case
            case .authorizedAlways, .authorizedWhenInUse:
                if let location = locManager.location {
                    region = MKCoordinateRegion(center: location.coordinate, span: MapDetails.defaultSpan)
                }
            @unknown default:
                break
        }
    }
}
