//
//  Terrain.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI

class Terrain : ObservableObject {
    var id = UUID()
    var name: String
    @Published var isSelected: Bool = true
    
    init(name: String) {
            self.name = name
    }
}
