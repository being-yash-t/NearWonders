//
//  Location.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import Foundation
import MapKit.MKTypes

struct Location {
    let title: String
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    
    var coordinates: CLLocationCoordinate2D {CLLocationCoordinate2D(
        latitude: lat,
        longitude: long
    )}
}

