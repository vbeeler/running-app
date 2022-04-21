//
//  ChooseLocationView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI
import MapKit

struct ChooseLocationView: View {
    @StateObject var locationManager : LocationManager
    
    @State var startingLocation : CLLocationCoordinate2D
    @State var endingLocation : CLLocationCoordinate2D
    
    var body: some View {
        MapView(locationManager: locationManager)
    }
}

struct ChooseLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseLocationView(locationManager: LocationManager(), startingLocation: CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365), endingLocation: CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365))
    }
}
