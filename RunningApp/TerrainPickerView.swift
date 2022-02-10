//
//  IngredientPickerView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI

struct TerrainPickerView: View {
    @StateObject var terrainTypes : TerrainTypes
    
    var body: some View{
        VStack {
            
            Text("Select the terrain types you would like:")
                .fontWeight(.bold)
            
            List {
                ForEach(0..<terrainTypes.terrains.count){ index in
                    HStack {
                        Button(action: {
                            terrainTypes.terrains[index].isSelected = terrainTypes.terrains[index].isSelected ? false : true
                    }) {
                            HStack{
                                if terrainTypes.terrains[index].isSelected {
                                    Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle")
                                            .foregroundColor(.primary)
                                }
                                Text(terrainTypes.terrains[index].name)
                            }
                        }.buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
        }
    }
}

struct TerrainPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TerrainPickerView(terrainTypes: TerrainTypes(terrains: [Terrain(name: "Road"), Terrain(name: "Dirt"), Terrain(name: "Grass"), Terrain(name: "Sand")]))
    }
}
