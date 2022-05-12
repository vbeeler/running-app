//
//  MetricCalculator.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/10/22.
//

import SwiftUI

class MetricCalculator {
    static func toMiles(meters:Double) -> Double {
        return meters / 1609.344
    }
    
    static func toMeters(miles:Double) -> Double {
        return miles * 1609.344
    }
    
    static func toMinutesPerMile(metersPerSecond: Double) -> Double {
        if metersPerSecond > 0 {
            return 1 / (metersPerSecond * 60 / 1609)
        }
        return -1
    }
    
    static func averageMinutesPerMile(activityTimer: ActivityTimer, distanceTraveled: Double) -> Double {
        let milesTraveled = toMiles(meters: distanceTraveled)
        if milesTraveled > 0 {
            return (Double(60 * activityTimer.hours) + Double(activityTimer.minutes) + Double(activityTimer.seconds) / 60) / milesTraveled
        }
        return -1
    }
}
