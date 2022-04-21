//
//  ActivityTimer.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 4/10/22.
//

import SwiftUI

class ActivityTimer : ObservableObject{
    @Published var hours : Int = 0
    @Published var minutes : Int = 0
    @Published var seconds : Int = 0
    
    @Published var isPaused : Bool = true
    @Published var timer : Timer? = nil
    
    init(locationManager: LocationManager) {
        startActivity(locationManager:locationManager)
    }
    
    func startActivity(locationManager: LocationManager){
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ tempTimer in
          if self.seconds == 59 {
            self.seconds = 0
            if self.minutes == 59 {
              self.minutes = 0
              self.hours = self.hours + 1
            } else {
              self.minutes = self.minutes + 1
            }
          } else {
            self.seconds = self.seconds + 1
          }
        }
        locationManager.isTracking = true
    }
    
    func pauseActivity(locationManager: LocationManager){
        isPaused = true
        timer?.invalidate()
        timer = nil
        locationManager.isTracking = false
    }
}
