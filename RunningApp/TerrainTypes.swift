//
//  TerrainTypes.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI

class TerrainTypes : ObservableObject{
    @Published var terrains : [Terrain]
    
    init(terrains: [Terrain]) {
        self.terrains = terrains
    }
}
