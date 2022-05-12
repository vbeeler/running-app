//
//  RouteView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/25/22.
//

import MapKit
import SwiftUI

struct RouteView: UIViewRepresentable {
    var routeRequest : RouteRequest

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let routeCalculator = RouteCalculator()
        routeCalculator.createRoute(mapView: mapView, routeRequest: routeRequest)
        
        return mapView
    }
        
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //uiView.setRegion(locationManager.region, animated: true)
        uiView.showsUserLocation = true
    }
    
    func makeCoordinator() -> MapRouteViewCoordinator {
      return MapRouteViewCoordinator()
    }
    
    class MapRouteViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
          let renderer = MKPolylineRenderer(overlay: overlay)
          renderer.strokeColor = .systemBlue
          renderer.lineWidth = 5
          return renderer
        }
    }
}
