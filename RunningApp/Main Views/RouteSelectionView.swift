//
//  RouteSelectionView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/20/22.
//

import SwiftUI

struct RouteSelectionView: View {
    @StateObject var locationManager : LocationManager
    var routeRequestDetails: RouteRequestDetails
  
    var body: some View {
        MapView(locationManager: locationManager)
    }
}
