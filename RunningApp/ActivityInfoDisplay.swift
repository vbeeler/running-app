//
//  ActivityInfoDisplay.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/1/22.
//

import SwiftUI

struct ActivityInfoDisplay: View {
    var parameter: String
    var value: Double
    var units: String
    
    var body: some View {
        VStack {
            Text("\(parameter)")
            
            HStack {
                Text("\(value)")
                
                Text("\(units)")
            }
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.blue, lineWidth: 4))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 90)
    }
}

struct ActivityInfoDisplay_Previews: PreviewProvider {
    static var previews: some View {
        ActivityInfoDisplay(parameter: "Speed", value: 1.2, units: "min/mile")
    }
}
