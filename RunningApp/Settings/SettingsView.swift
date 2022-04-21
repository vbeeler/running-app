//
//  SettingsView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 3/3/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedDistanceUnits = "mi"
    @State private var selectedAltitudeUnits = "ft"
    
    private var distanceUnits = ["mi", "km"]
    private var altitudeUnits = ["ft", "m"]
    
    var body: some View {
        NavigationView {            
            Form {
                Section(header: Text("Units of Measurement")) {
                    Picker("Distance Units", selection: $selectedDistanceUnits) {
                        ForEach(distanceUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Picker("Altitude Units", selection: $selectedAltitudeUnits) {
                        ForEach(altitudeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
