//
//  RecordView.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/1/22.
//

import SwiftUI

struct RecordView: View {
    @StateObject var locationManager : LocationManager

    var body: some View {
        ZStack {
            MapView(locationManager: locationManager)
            NavigationLink(destination: RunView(locationManager: locationManager)) {
                HStack {
                    Text("Run")
                        .fontWeight(.semibold)
                        .font(.title)
                    Image(systemName: "figure.walk.circle.fill")
                        .font(.title)
                }
                .frame(minWidth: 0, maxWidth: 160)
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            }
            .offset(x:0,y:200)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(locationManager: LocationManager())
    }
}
