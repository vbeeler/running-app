//
//  TerrainTypes.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI

class TerrainTypes : ObservableObject{
    @Published var road : Bool = true
    @Published var dirt : Bool = true
    @Published var grass : Bool = true
    @Published var sand : Bool = true
}
