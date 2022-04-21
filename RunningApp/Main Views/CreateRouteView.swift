//
//  CreateRouteView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/29/22.
//

import SwiftUI
import MapKit

struct CreateRouteView: View {
    var locationManager : LocationManager
    var settings : Settings
    
    @State private var selectedActivity = ActivityType.running
    @State private var milesSelection = 4
    @State private var hundredthMileSelection = 0
    @StateObject var terrainTypeSelections: TerrainTypes = TerrainTypes()
    @State private var startingLocationSelection : CLLocationCoordinate2D = MapDetails.defaultStartingLocation
    @State private var endingLocationSelection : CLLocationCoordinate2D = MapDetails.defaultEndingLocation
    @State private var altitudeSelection : Float = 0
    @State private var isEditingAltitude = false
    
    private var activities = ActivityType.allCases
    private var miles = [Int](0..<100)
    private var hundredthMiles = [Int](0..<100).map { Float($0) / 100 }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    Section() {
                        Picker("Select an activity type", selection: $selectedActivity) {
                            ForEach(activities, id: \.self) {
                                Text($0.rawValue)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        Section() {
                            HStack(spacing: 0) {
                                Text("Distance")
                                
                                Picker("Miles", selection: $milesSelection) {
                                    ForEach(0 ..< miles.count) {
                                        Text("\($0)")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: geometry.size.width/5, alignment: .center)
                                .compositingGroup()
                                .clipped()
                                
                                Picker("Hundredth Miles", selection: $hundredthMileSelection) {
                                    ForEach(hundredthMiles, id: \.self) {
                                        Text("\($0, specifier: "%.2f")")
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: geometry.size.width/5, alignment: .center)
                                .compositingGroup()
                                .clipped()
                                
                                Text(" \(settings.distanceUnits)")
                            }
                        }
                        
                        Section {
                            TerrainPickerView(terrainTypes: terrainTypeSelections)
                        }
                        
                        Section {
                            NavigationLink(destination: ChooseLocationView(locationManager: locationManager, startingLocation: startingLocationSelection, endingLocation: endingLocationSelection)) {
                                HStack {
                                    Text("Locations")
                                    Spacer()
                                    Image(systemName: "location.circle.fill")
                                }
                            }
                        }
                        
                        Section {
                            VStack {
                                HStack {
                                    Text("Altitude Change")
                                    
                                    Spacer()
                                    
                                    
                                    Text("\(altitudeSelection, specifier: "%.1f")\(settings.altitudeUnits)")
                                }
                                
                                Slider(
                                    value: $altitudeSelection,
                                            in: 0...100,
                                            onEditingChanged: { editing in
                                                isEditingAltitude = editing
                                            }
                                        )
                            }
                        }
                    }
                    
                    Button(action: {
                        createRoute()
                    }) {
                        Text("CREATE ROUTE")
                            .font(.title)
                            .frame(minWidth: 60, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 35, maxHeight: 35, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .foregroundColor(Color.white)
                    }
                    .background(Color.red)
                    .cornerRadius(16)
                }
            }
        }
    }

    func createRoute() {
        let distance = Float(milesSelection) + 0.01 * Float(hundredthMileSelection);
        let routeDetails = RouteRequestDetails(distance: distance, startingLocation: startingLocationSelection, endingLocation: endingLocationSelection, terrain: terrainTypeSelections, altitude: altitudeSelection, activity: selectedActivity, routeType: RouteType.pointToPoint)
        let bestRoute = RouteCalculator.calculateRoute(routeDetails: routeDetails, locationManager: locationManager)
        print(bestRoute)
    }
    
    init(_ locationManager: LocationManager, _ settings: Settings) {
        self.locationManager = locationManager
        self.settings = settings
        
        //this will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)

        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.red], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .normal)
    }
}


struct CreateRouteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRouteView(LocationManager(), Settings())
    }
}
