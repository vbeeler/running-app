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
    @Binding var startingLocation : CLLocationCoordinate2D
    @Binding var endingLocation : CLLocationCoordinate2D
    @StateObject var locationService : LocationService
    @State var locationType : LocationType
    
    @Environment(\.dismiss) var dismiss
    @State var isShowingEndLocationView = false
    @State var isShowingHomeView = false
  
    var body: some View {
        VStack {
            Form {
                Text("Choose your \(locationType.rawValue) location.")
                
                Section(header: Text("Location Search")) {
                    ZStack(alignment: .trailing) {
                        TextField("Search", text: $locationService.queryFragment)
                        // This is optional and simply displays an icon during an active search
                        if locationService.status == .isSearching {
                            Image(systemName: "clock")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                Section(header: Text("Results")) {
                    List {
                        // With Xcode 12, this will not be necessary as it supports switch statements.
                        Group { () -> AnyView in
                            switch locationService.status {
                            case .noResults: return AnyView(Text("No Results"))
                            case .error(let description): return AnyView(Text("Error: \(description)"))
                            default: return AnyView(EmptyView())
                            }
                        }.foregroundColor(Color.gray)
                        
                        
                        // WANT - navigate to this page again to set ending location if currently setting starting location
                        //        else, if setting ending location, navigate back to create route page
                        // currently trying to implement search auto complete and filling starting and ending locations for route creation
                        // current error - why is "HI" string printing a LOT? and the view is not navigating correctly, stays at current view
                        if locationType == LocationType.starting {
                            ForEach(locationService.searchResults, id: \.self) { completionResult in
                                VStack {
                                    Button("\(completionResult.title) \(completionResult.subtitle)") {
                                        search(completionResult: completionResult, locationType: LocationType.starting)
                                        locationType = LocationType.ending
                                        locationService.queryFragment = ""
                                    }
                                }
                            }
                        } else {
                            ForEach(locationService.searchResults, id: \.self) { completionResult in
                                Button("\(completionResult.title) \(completionResult.subtitle)") {
                                    search(completionResult: completionResult, locationType: LocationType.ending)
                                    isShowingEndLocationView = false
                                    dismiss()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func search(completionResult : MKLocalSearchCompletion, locationType : LocationType) {
        let searchRequest = MKLocalSearch.Request(completion: completionResult)

        // Set the region to an associated map view's region.
        searchRequest.region = MKCoordinateRegion(center: locationManager.locationCoordinate, span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20))

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard let response = response else {
                // Handle the error.
                print("Search error: \(error!.localizedDescription)")
                return
            }
            
            let item = response.mapItems[0]
            if let name = item.name,
                let location = item.placemark.location {
                print("\(name): \(location.coordinate.latitude),\(location.coordinate.longitude)")
                if locationType == LocationType.starting {
                    self.startingLocation = location.coordinate
                } else {
                    self.endingLocation = location.coordinate
                }
            }
        }
    }
}
