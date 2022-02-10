//
//  ChooseLocationView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI
import MapKit

struct ChooseLocationView: View {
    @State var startingLocation : CLLocationCoordinate2D
    @State var endingLocation : CLLocationCoordinate2D
    
    var body: some View {
        MapView()
    }
}

struct ChooseLocationView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseLocationView(startingLocation: CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365),
                           endingLocation: CLLocationCoordinate2D(latitude: 38.8977, longitude: 77.0365))
    }
}
