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
        
        let sourcePlaceMark = MKPlacemark(coordinate: routeRequest.startingLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: routeRequest.endingLocation)
        
        let request = MKDirections.Request()
     
        if routeRequest.activity == ActivityType.biking {
            request.transportType = .automobile
        } else if routeRequest.activity == ActivityType.running {
            request.transportType = .walking
        }
        
        if (routeRequest.routeType == RouteType.pointToPoint) {
            request.source = MKMapItem(placemark: sourcePlaceMark)
            request.destination = MKMapItem(placemark: destinationPlaceMark)
            
            let directions = MKDirections(request: request)

            directions.calculate { response, error in
                guard let route = response?.routes.first else {
                    print("Error: \(error?.localizedDescription ?? "No error specified").")
                    return
                }
                
                mapView.addAnnotations([sourcePlaceMark, destinationPlaceMark])
                mapView.addOverlay(route.polyline)
                mapView.setVisibleMapRect(
                    route.polyline.boundingMapRect,
                    edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                    animated: true
                )
            }
        }
        
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
