//
//  RunView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/1/22.
//

import SwiftUI
import CoreLocation

struct RunView: View {
    @StateObject var locationManager : LocationManager
    
    var body: some View {
        VStack(spacing:0) {
            MapView(locationManager: locationManager)
            
            HStack {
                ActivityInfoDisplay(parameter: "Current Speed", value: 8.4, units: "min/mile")
                ActivityInfoDisplay(parameter: "Average Speed", value: 8.2, units: "min/mile")
            }
            
            HStack {
                ActivityInfoDisplay(parameter: "Distance", value: 2.6, units: "miles")
                ActivityInfoDisplay(parameter: "Time", value: 40.1, units: "mins")
            }
        }
    }
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        RunView(locationManager: LocationManager())
    }
}
