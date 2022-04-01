//
//  Settings.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 3/10/22.
//

import SwiftUI

class Settings : ObservableObject{
    @Published var distanceUnits : String = "mi"
    @Published var altitudeUnits : String = "ft"
}
