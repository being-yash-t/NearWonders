//
//  Location.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import Foundation
import MapKit.MKTypes

struct Location {
    let title: String?
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    
    var coordinates: CLLocationCoordinate2D {CLLocationCoordinate2D(
        latitude: lat,
        longitude: long
    )}
    
    init(lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.title = nil
        self.lat = lat
        self.long = long
    }
    
    init(title: String?, lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.title = title
        self.lat = lat
        self.long = long
    }
}

