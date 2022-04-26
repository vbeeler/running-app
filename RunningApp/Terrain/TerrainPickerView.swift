//
//  IngredientPickerView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 2/9/22.
//

import SwiftUI

struct TerrainPickerView: View {
    @ObservedObject var terrainTypes : TerrainSelection
    
    var body: some View{
        VStack {
            HStack {
                Text("Terrain Types")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                Button(action: { terrainTypes.road = terrainTypes.road ? false : true }) {
                    HStack{
                        if terrainTypes.road {
                            Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle")
                                    .foregroundColor(.primary)
                        }
                        Text("Road")
                    }
                }.buttonStyle(BorderlessButtonStyle())
                
                Button(action: { terrainTypes.dirt = terrainTypes.dirt ? false : true }) {
                    HStack{
                        if terrainTypes.dirt {
                            Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle")
                                    .foregroundColor(.primary)
                        }
                        Text("Dirt")
                    }
                }.buttonStyle(BorderlessButtonStyle())
                
                Button(action: { terrainTypes.grass = terrainTypes.grass ? false : true }) {
                    HStack{
                        if terrainTypes.grass {
                            Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle")
                                    .foregroundColor(.primary)
                        }
                        Text("Grass")
                    }
                }.buttonStyle(BorderlessButtonStyle())
                
                Button(action: { terrainTypes.sand = terrainTypes.sand ? false : true }) {
                    HStack{
                        if terrainTypes.sand {
                            Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                        } else {
                            Image(systemName: "circle")
                                    .foregroundColor(.primary)
                        }
                        Text("Sand")
                    }
                }.buttonStyle(BorderlessButtonStyle())
            }
        }
    }
}

struct TerrainPickerView_Previews: PreviewProvider {
    static var previews: some View {
        TerrainPickerView(terrainTypes: TerrainSelection())
    }
}
