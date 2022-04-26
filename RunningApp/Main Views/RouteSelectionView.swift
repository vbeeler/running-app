//
//  RouteSelectionView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/20/22.
//

import SwiftUI

struct RouteSelectionView: View {
    @StateObject var locationManager : LocationManager
    var routeRequest: RouteRequest
  
    var body: some View {
        MapView(locationManager: locationManager)
    }
}
