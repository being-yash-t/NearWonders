//
//  LocationDetails.swift
//  NearWonders
//
//  Created by Jay Thakur on 28/12/23.
//

import Foundation
import MapKit.MKTypes

struct LocationDetails {
    let title: String
    let description: String?
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    
    let activities: [Activity]
    let bestSeasons: [Season]
    let previewImages: Set<String>
    
    var coordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}
