//
//  RouteCalculator.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 5/7/22.
//

import SwiftUI
import MapKit

class RouteCalculator {
    public func createRoute(mapView: MKMapView, routeRequest: RouteRequest) {
        if (routeRequest.routeType == RouteType.pointToPoint) {
            self.createP2PRoute(mapView: mapView, routeRequest: routeRequest)
        }
        
        else if (routeRequest.routeType == RouteType.outAndBack) {
            self.createOutAndBackRoute(mapView: mapView, routeRequest: routeRequest)
        }
        
        else if (routeRequest.routeType == RouteType.loop) {
            self.createLoopRoute(mapView: mapView, routeRequest: routeRequest)
        }
    }
    
    private func createLoopRoute(mapView: MKMapView, routeRequest: RouteRequest) {
        let sourcePlaceMark = MKPlacemark(coordinate: routeRequest.startingLocation)
        let points = LocationCalculator.generateNRandomPoints(startingLocation: routeRequest.startingLocation, distance: routeRequest.distance / 2, n: 10)
        
        calculateRoutes(sourcePlaceMark: sourcePlaceMark, destinationCoordinates: points) { routes in
            var routesT = routes
            routesT.sort(by: {$0.1 < $1.1})
            var destinationPlaceMarks : [MyPlacemark] = []
            var routesThere : [MKRoute] = []
            for route in routesT {
                routesThere.append(route.0)
                destinationPlaceMarks.append(route.1)
            }
            
            self.calculateBackRoutes(sourcePlaceMarks: destinationPlaceMarks, destinationPlaceMark: sourcePlaceMark, routesThere: routesThere) { routes in
                var routesB = routes
                routesB.sort(by: {$0.1 < $1.1})
                var routesBack : [MKRoute] = []
                for route in routesB {
                    routesBack.append(route.0)
                    destinationPlaceMarks.append(route.1)
                }
                
                let bestRoutes = self.getBestLoopRoute(routesThere: routesThere, routesBack: routesBack, routeRequest: routeRequest)
                
                print("DISTANCE \(MetricCalculator.toMiles(meters:bestRoutes[0].distance + bestRoutes[1].distance))")
                mapView.addAnnotations([sourcePlaceMark])
                mapView.addOverlay(bestRoutes[0].polyline)
                mapView.addOverlay(bestRoutes[1].polyline)
                mapView.setVisibleMapRect(
                    bestRoutes[0].polyline.boundingMapRect,
                    edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                    animated: true
                )
            }
        }
    }
    
    private func createOutAndBackRoute(mapView: MKMapView, routeRequest: RouteRequest) {
        let sourcePlaceMark = MKPlacemark(coordinate: routeRequest.startingLocation)
        let points = LocationCalculator.generateNRandomPoints(startingLocation: routeRequest.startingLocation, distance: routeRequest.distance / 2, n: 10)
        
        calculateRoutes(sourcePlaceMark: sourcePlaceMark, destinationCoordinates: points) { routes in
            let route = self.getBestOutAndBackRoute(routes: routes, routeRequest: routeRequest)

            print("DISTANCE \(MetricCalculator.toMiles(meters:route.distance))")
            mapView.addAnnotations([sourcePlaceMark])
            mapView.addOverlay(route.polyline)
            mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                animated: true
            )
        }
    }

    private func createP2PRoute(mapView: MKMapView, routeRequest: RouteRequest) {
        let directionsRequest = MKDirections.Request()
        
        let sourcePlaceMark = MKPlacemark(coordinate: routeRequest.startingLocation)
        let destinationPlaceMark = MKPlacemark(coordinate: routeRequest.endingLocation)
        
        directionsRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionsRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        let directions = MKDirections(request: directionsRequest)

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
    
    private func calculateRoutes(sourcePlaceMark: MKPlacemark, destinationCoordinates: [CLLocationCoordinate2D], completion: @escaping([(MKRoute, MyPlacemark)]) -> Void) {
        let group = DispatchGroup()
        var routes: [(MKRoute, MyPlacemark)] = []
        var destinationPlaceMark : MKPlacemark
        
        for idx in 0 ..< destinationCoordinates.count {
            group.enter()
            destinationPlaceMark = MKPlacemark(coordinate: destinationCoordinates[idx])
            calculateRoute(sourcePlaceMark: sourcePlaceMark, destinationPlaceMark: destinationPlaceMark) { route in
                routes.append((route.0, MyPlacemark(placemark: route.1, index: idx)))
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(routes)
        }
    }
    
    private func calculateBackRoutes(sourcePlaceMarks: [MyPlacemark], destinationPlaceMark: MKPlacemark, routesThere: [MKRoute], completion: @escaping([(MKRoute, MyPlacemark)]) -> Void) {
        let group = DispatchGroup()
        var routes: [(MKRoute, MyPlacemark)] = []
        
        for i in 0 ..< sourcePlaceMarks.count {
            group.enter()
            calculateRouteBack(sourcePlaceMark: sourcePlaceMarks[i].placemark, destinationPlaceMark: destinationPlaceMark, routeThere: routesThere[i]) { route in
                routes.append((route, sourcePlaceMarks[i]))
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion(routes)
        }
    }
    
    private func calculateRouteBack(sourcePlaceMark: MKPlacemark, destinationPlaceMark: MKPlacemark, routeThere: MKRoute, completion: @escaping(MKRoute) -> Void) {
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionsRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        directionsRequest.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: directionsRequest)

        directions.calculate { response, error in
            guard let potentialRoutes = response?.routes else {
                print("Error: \(error?.localizedDescription ?? "No error specified").")
                return
            }
            
            if potentialRoutes.count == 1 || potentialRoutes[0] != routeThere {
                completion(potentialRoutes[0])
            } else {
                completion(potentialRoutes[1])
            }
        }
    }
    
    private func calculateRoute(sourcePlaceMark: MKPlacemark, destinationPlaceMark: MKPlacemark, completion: @escaping((MKRoute, MKPlacemark)) -> Void) {
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = MKMapItem(placemark: sourcePlaceMark)
        directionsRequest.destination = MKMapItem(placemark: destinationPlaceMark)
        
        let directions = MKDirections(request: directionsRequest)

        directions.calculate { response, error in
            guard let route = response?.routes.first else {
                print("Error: \(error?.localizedDescription ?? "No error specified").")
                return
            }
            
            completion((route, destinationPlaceMark))
        }
    }
    
    private func getBestOutAndBackRoute(routes: [(MKRoute, MyPlacemark)], routeRequest: RouteRequest) -> MKRoute {
        var bestRoute : MKRoute = routes[0].0
        
        for route in routes {
            print("distance: \(MetricCalculator.toMiles(meters:route.0.distance))")
            print("altitude: \(LocationCalculator.getAltitudeChangeAlongRoute(route: route.0))")
            if abs(route.0.distance - MetricCalculator.toMeters(miles:routeRequest.distance) / 2) < abs(bestRoute.distance - MetricCalculator.toMeters(miles:routeRequest.distance) / 2) {
                bestRoute = route.0
            }
        }
        
        return bestRoute
    }
    
    private func getBestLoopRoute(routesThere: [MKRoute], routesBack: [MKRoute], routeRequest: RouteRequest) -> [MKRoute] {
        var bestRouteThere : MKRoute = routesThere[0]
        var bestRouteBack : MKRoute = routesBack[0]
        var bestDistance : Double = routesThere[0].distance + routesBack[0].distance
        
        for i in 0 ..< routesThere.count {
            let curDistance = routesThere[i].distance + routesBack[i].distance
            print("distance: \(MetricCalculator.toMiles(meters:routesThere[i].distance + routesBack[i].distance))")
            if abs(curDistance - MetricCalculator.toMeters(miles:routeRequest.distance)) < abs(bestDistance - MetricCalculator.toMeters(miles:routeRequest.distance)) {
                bestRouteThere = routesThere[i]
                bestRouteBack = routesBack[i]
                bestDistance = curDistance
            }
        }
        
        return [bestRouteThere, bestRouteBack]
    }
}
