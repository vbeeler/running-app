//
//  RouteCalculator.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/20/22.
//

import MapKit
import SwiftUI

class RouteCalculator {
    static func calculateRoute(routeDetails:RouteRequestDetails, locationManager:LocationManager) -> Route {
        if (routeDetails.routeType == RouteType.pointToPoint) {
            let request = MKDirections.Request()

            let sourcePlaceMark = MKPlacemark(coordinate: routeDetails.startingLocation)
            request.source = MKMapItem(placemark: sourcePlaceMark)
            let destinationPlaceMark = MKPlacemark(coordinate: routeDetails.endingLocation)
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            
            if routeDetails.activity == ActivityType.biking {
                request.transportType = .automobile
            } //else if routeDetails.activity == ActivityType.running {
                //request.transportType = .walking
            //}

            let directions = MKDirections(request: request)

            directions.calculate { response, error in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "No error specified").")
                    return
                }

                let route = response.routes[0]
                print(route)
            }
        }
        
        return Route(distance: 0, origin: locationManager.locationCoordinate, endpoint: locationManager.locationCoordinate)
    }
}
