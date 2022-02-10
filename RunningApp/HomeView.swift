//
//  HomeView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 1/28/22.
//

import MapKit
import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Record", systemImage: "record.circle")
                }
            
            CreateRouteView()
            // change to picture of route
                .tabItem {
                    Label("Create", systemImage: "mappin.and.ellipse")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
