//
//  CreateRouteView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/29/22.
//

import SwiftUI
import MapKit

struct CreateRouteView: View {
    @State private var selectedActivity = "RUN"
    @State private var milesSelection = 4
    @State private var hundredthMileSelection = 0
    @StateObject var terrainTypeSelections: TerrainTypes = TerrainTypes(terrains: [Terrain(name: "Road"), Terrain(name: "Dirt"), Terrain(name: "Grass"), Terrain(name: "Sand")])
    @State private var startingLocationSelection : CLLocationCoordinate2D = MapDetails.defaultLocation
    @State private var endingLocationSelection : CLLocationCoordinate2D = MapDetails.defaultLocation
    
    private var activities = ["RUN", "BIKE"]
    private var miles = [Int](0..<100)
    private var hundredthMiles = [Int](0..<100).map { Float($0) / 100 }

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                Form {
                    Section() {
                        Picker("Select an activity type", selection: $selectedActivity) {
                            ForEach(activities, id: \.self) {
                                Text($0)
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
                                
                                Text(" miles")
                            }
                        }
                        
                        Section {
                            NavigationLink(destination: TerrainPickerView(terrainTypes: terrainTypeSelections)) {
                                Text("Terrain Types")
                            }
                        }
                        
                        Section {
                            NavigationLink(destination: ChooseLocationView(startingLocation: startingLocationSelection, endingLocation: endingLocationSelection)) {
                                HStack {
                                    Text("Locations")
                                    Spacer()
                                    Image(systemName: "location.circle.fill")
                                }
                            }
                        }
                    }

                    Section {
                        Button("Save changes") {
                            // activate theme!
                        }
                    }
                }
            }
        }
    }
    
    init() {
        //this will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .largeTitle)], for: .normal)

        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.red], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .normal)
    }
}


struct CreateRouteView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRouteView()
    }
}
