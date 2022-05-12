//
//  MyPlacemark.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 5/12/22.
//

import MapKit
import SwiftUI

class MyPlacemark: Identifiable, Comparable {
    let placemark:MKPlacemark
    let index:Int
    
    init(placemark : MKPlacemark, index : Int) {
        self.placemark = placemark
        self.index = index
    }
    
    static func < (lhs: MyPlacemark, rhs: MyPlacemark) -> Bool {
            lhs.index < rhs.index
    }
    
    static func == (lhs: MyPlacemark, rhs: MyPlacemark) -> Bool {
        return lhs.index == rhs.index
    }
}
