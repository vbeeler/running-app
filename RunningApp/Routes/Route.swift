//
//  Route.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/29/22.
//

import MapKit
import SwiftUI

class Route: ObservableObject {
    let name:String
    let distance:Float
    @Published var origin:CLLocationCoordinate2D
    @Published var endpoint:CLLocationCoordinate2D
    let route:MKRoute
    
    init(name: String = "",
         distance: Float,
         origin: CLLocationCoordinate2D,
         endpoint: CLLocationCoordinate2D,
         route: MKRoute) {
        self.name = name
        self.distance = distance
        self.origin = origin
        self.endpoint = endpoint
        self.route = route
    }
}
