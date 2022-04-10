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
    @StateObject var activityTimer : ActivityTimer

    var body: some View {
        VStack(spacing:0) {
            MapView(locationManager: locationManager)
            
            HStack {
                ActivityInfoDisplay(parameter: "Elapsed Time", value: "\(String(format: "%02d", activityTimer.hours)):\(String(format: "%02d", activityTimer.minutes)):\(String(format: "%02d", activityTimer.seconds))", units: "")
                ActivityInfoDisplay(parameter: "Current Speed", value: "\(String(format: "%02d:%02d", Int(MetricCalculator.toMinutesPerMile(metersPerSecond: locationManager.speed)), Int(MetricCalculator.toMinutesPerMile(metersPerSecond: locationManager.speed).truncatingRemainder(dividingBy: 1) * 60)))" , units: "min/mile")
            }
            
            HStack {
                ActivityInfoDisplay(parameter: "Distance", value: "\(String(format: "%01.2lf", MetricCalculator.toMiles(meters: locationManager.distanceTraveled)))" , units: "miles")
                ActivityInfoDisplay(parameter: "Average Speed", value: "\(String(format: "%02d:%02d", Int(MetricCalculator.averageMinutesPerMile(activityTimer: activityTimer, distanceTraveled: locationManager.distanceTraveled)), Int(MetricCalculator.averageMinutesPerMile(activityTimer: activityTimer, distanceTraveled: locationManager.distanceTraveled).truncatingRemainder(dividingBy: 1) * 60)))" , units: "min/mile")
            }
        }
    }
}

struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        let locationManager: LocationManager = LocationManager()
        RunView(locationManager: locationManager, activityTimer: ActivityTimer(locationManager: locationManager))
    }
}
