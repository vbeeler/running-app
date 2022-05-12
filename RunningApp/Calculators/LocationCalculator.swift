//
//  LocationCalculator.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 5/7/22.
//

import SwiftUI
import MapKit

class LocationCalculator {
    // earth radius in meters
    static let EARTH_RADIUS : Double = 6.3781 * pow(10, 6)
    
    static func toRadians(degrees: Double) -> Double {
        return Double.pi * degrees / 180
    }
    
    static func toDegrees(radians: Double) -> Double {
        return 180 * radians / Double.pi
    }
    
    static func generateNRandomPoints(startingLocation: CLLocationCoordinate2D, distance: Double, n: Int) -> [CLLocationCoordinate2D] {
        var randomPoints : [CLLocationCoordinate2D] = []
        var theta : Double = 0
        var delta : Double = 0
        let lat1 = toRadians(degrees: startingLocation.latitude)
        let long1 = toRadians(degrees: startingLocation.longitude)
        var lat2 : Double = 0
        var long2 : Double = 0
        var modDistance : Double = 0
        for _ in 1...n {
            theta = Double.random(in: 0.0 ..< 2 * Double.pi)
            modDistance = distance / Double.random(in: 1.3 ..< 1.4)
            delta = MetricCalculator.toMeters(miles: modDistance) / EARTH_RADIUS
            lat2 = asin(sin(lat1) * cos(delta) + cos(lat1) * sin(delta) * cos(theta))
            long2 = long1 + atan2(sin(theta) * sin(delta) * cos(lat1), cos(delta) - sin(lat1) * sin(lat2))
            long2 = (long2 + 3 * Double.pi).truncatingRemainder(dividingBy: 2 * Double.pi) - Double.pi
            randomPoints.append(CLLocationCoordinate2D(latitude: toDegrees(radians: lat2), longitude: toDegrees(radians: long2)))
        }
        return randomPoints
    }
    
    static func getAltitudeChangeAlongRoute(route: MKRoute) -> Double {
        var totalAltitudeChange : Double = 0
        
        let points : [CLLocationCoordinate2D] = route.polyline.coordinates
        let nextLocation : CLLocation = CLLocation(latitude: points[0].latitude, longitude: points[0].longitude)
        print(nextLocation.altitude)
        for idx in 1 ..< points.count {
            let curLocation = nextLocation
            let nextLocation : CLLocation = CLLocation(latitude: points[idx].latitude, longitude: points[idx].longitude)
            totalAltitudeChange += abs(nextLocation.altitude - curLocation.altitude)
        }
        
        return totalAltitudeChange
    }
}
