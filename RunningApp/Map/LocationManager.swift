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
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(center: MapDetails.defaultLocation, span: MapDetails.defaultSpan)
    @Published var location: CLLocation = CLLocation()
    @Published var locationCoordinate: CLLocationCoordinate2D = MapDetails.defaultLocation
    @Published var speed: Double
    @Published var isTracking: Bool
    @Published var distanceTraveled: Double

    override init() {
        self.speed = 0
        self.isTracking = false
        self.distanceTraveled = 0
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
    
    func startTracking() {
        self.isTracking = true
    }
    
    func pauseTracking() {
        self.isTracking = false
    }
    
    func stopTracking() {
        self.isTracking = false
        self.distanceTraveled = 0
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty {
            if isTracking {
                distanceTraveled += location.distance(from:locations.first!)
            }
            region = MKCoordinateRegion(center: locations.first!.coordinate, span: MapDetails.defaultSpan)
            location = locations.first!
            locationCoordinate = locations.first!.coordinate
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
                requestUpdatingLocation()
            @unknown default:
                break
        }
    }
}
