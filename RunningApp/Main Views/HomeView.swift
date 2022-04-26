//
//  HomeView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/28/22.
//

import MapKit
import SwiftUI

struct HomeView: View {
    @StateObject private var locationManager : LocationManager = LocationManager()
    var settings : Settings
    @StateObject private var locationService : LocationService = LocationService()
    
    var body: some View {
        NavigationView {
            TabView {
                RecordView(locationManager: locationManager)
                    .tabItem {
                        Label("Record", systemImage: "record.circle")
                }
                
                CreateRouteView(locationManager, settings, locationService)
                // change to picture of route
                    .tabItem {
                        Label("Create", systemImage: "mappin.and.ellipse")
                }
            }
            .navigationBarTitle("Welcome!")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text("")
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .font(.title)
                        }
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(settings:Settings())
    }
}
