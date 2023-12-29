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
    let description: String?
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    
    var coordinates: CLLocationCoordinate2D {CLLocationCoordinate2D(
        latitude: lat,
        longitude: long
    )}
    
    init(title: String, description: String?, lat: CLLocationDegrees, long: CLLocationDegrees) {
        self.title = title
        self.description = description
        self.lat = lat
        self.long = long
    }
    
    init(title: String, description: String?, coordinates: CLLocationCoordinate2D) {
        self.title = title
        self.description = description
        self.lat = coordinates.latitude
        self.long = coordinates.longitude
    }
    
}

