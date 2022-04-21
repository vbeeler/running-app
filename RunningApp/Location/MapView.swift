//
//  MapView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/28/22.
//

import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    @StateObject var locationManager : LocationManager

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
        
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(locationManager.region, animated: true)
        uiView.showsUserLocation = true
    }
}
