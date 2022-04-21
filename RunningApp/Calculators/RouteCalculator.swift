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
        if (routeDetails.routeType == RouteType.loop || routeDetails.routeType == RouteType.outAndBack) {
            print("BOOYEAH")
        }
        
        return Route(distance: 0, origin: locationManager.locationCoordinate, endpoint: locationManager.locationCoordinate)
    }
}
