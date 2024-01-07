//
//  LocationDetails.swift
//  NearWonders
//
//  Created by Jay Thakur on 28/12/23.
//

import Foundation

struct LocationDetails {
    let title: String
    let description: String?
    let locationCoordinates: LocationCoordinates
    
    let activities: [Activity]
    let bestSeasons: [Season]
    let previewImages: Set<String>
}
