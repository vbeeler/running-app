//
//  RouteDetails.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/20/22.
//

import MapKit
import SwiftUI

class RouteRequestDetails {
    let distance:Float
    let startingLocation:CLLocationCoordinate2D
    let endingLocation:CLLocationCoordinate2D
    let terrain:TerrainTypes
    let altitude:Float
    let activity:ActivityType
    let routeType:RouteType
    
    init(distance: Float,
         startingLocation: CLLocationCoordinate2D,
         endingLocation: CLLocationCoordinate2D,
         terrain: TerrainTypes,
         altitude: Float,
         activity: ActivityType,
         routeType: RouteType)
    {
        self.distance = distance
        self.startingLocation = startingLocation
        self.endingLocation = endingLocation
        self.terrain = terrain
        self.altitude = altitude
        self.activity = activity
        self.routeType = routeType
    }
}
