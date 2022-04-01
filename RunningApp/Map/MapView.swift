//
//  MapView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/28/22.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject var locationManager : LocationManager
    
    var body: some View {
        Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
            .accentColor(Color(.systemRed))
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationManager: LocationManager())
    }
}
