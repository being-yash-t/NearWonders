//
//  Location.swift
//  NearWonders
//
//  Created by Jay Thakur on 29/12/23.
//

import Foundation
import MapKit.MKTypes

struct LocationCoordinates {
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    
   var coordinates: CLLocationCoordinate2D {CLLocationCoordinate2D(
        latitude: lat,
        longitude: long
    )}
    
    init(lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.lat = lat
        self.long = long
    }
    
    init(_ coordinates: CLLocationCoordinate2D) {
        self.lat = coordinates.latitude
        self.long = coordinates.longitude
    }
}
