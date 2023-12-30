//
//  UserActivity.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import Foundation

class LocationSummary: Identifiable {
    let id: UUID
    let title: String
    let date: Date
    let images: Set<String>
    let bookmarks: Int
    let activities: Set<Activity>
    let locationCoordinates: LocationCoordinates
    
    init(
        id: UUID,
        title: String,
        date: Date,
        images: Set<String>,
        bookmarks: Int,
        activities: Set<Activity>,
        location: LocationCoordinates
    ) {
        self.id = id
        self.title = title
        self.date = date
        self.images = images
        self.bookmarks = bookmarks
        self.activities = activities
        self.locationCoordinates = location
    }
}
