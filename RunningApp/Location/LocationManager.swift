//
//  LocationManager.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/10/22.
//

import CoreLocation
import MapKit

enum MapDetails {
    static let defaultStartingLocation = CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365)
    static let defaultEndingLocation = CLLocationCoordinate2D(latitude: 38.910838, longitude: 77.027028)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(center: MapDetails.defaultStartingLocation, span: MapDetails.defaultSpan)
    @Published var location: CLLocation = CLLocation()
    @Published var locationCoordinate: CLLocationCoordinate2D = MapDetails.defaultStartingLocation
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
        guard let firstLocation = locations.first else {
          return
        }
        
        if isTracking {
            distanceTraveled += location.distance(from:firstLocation)
        }
        region = MKCoordinateRegion(center: firstLocation.coordinate, span: MapDetails.defaultSpan)
        location = firstLocation
        locationCoordinate = firstLocation.coordinate
        speed = firstLocation.speed
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
