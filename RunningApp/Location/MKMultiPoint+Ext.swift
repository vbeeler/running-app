//
//  MKMultiPoint+Ext.swift
//  RunningApp
//
//  Created by Vanessa Beeler on 5/7/22.
//

import SwiftUI
import MapKit

public extension MKMultiPoint {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid,
                                              count: pointCount)

        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))

        return coords
    }
}
