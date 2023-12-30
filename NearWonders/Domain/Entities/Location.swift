//
//  Location.swift
//  NearWonders
//
//  Created by Jay Thakur on 30/12/23.
//

import Foundation

struct Location {
    let id: String?
    let title: String
    let description: String
    let locationCoordinates: LocationCoordinates
    
    let activities: [Activity]
    let bestSeasons: [Season]
    
    init(title: String, description: String, locationCoordinates: LocationCoordinates, activities: [Activity], bestSeasons: [Season]) {
        self.id = nil
        self.title = title
        self.description = description
        self.locationCoordinates = locationCoordinates
        self.activities = activities
        self.bestSeasons = bestSeasons
    }
    
    init(id: String?, description: String, title: String, locationCoordinates: LocationCoordinates, activities: [Activity], bestSeasons: [Season]) {
        self.id = id
        self.title = title
        self.description = description
        self.locationCoordinates = locationCoordinates
        self.activities = activities
        self.bestSeasons = bestSeasons
    }
}
