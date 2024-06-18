//
//  UserActivity.swift
//  NearWonders
//
//  Created by Jay Thakur on 19/12/23.
//

import Foundation
import MapKit.MKTypes

struct LocationSummary: Identifiable, Decodable {
    let id: UUID
    let title: String
    let date: Date
    let images: Set<String>
    let bookmarks: Int
    let activities: Set<Activity>
    let locationCoordinates: LocationCoordinates
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case date
        case images
        case bookmarks
        case activities
        case latitude
        case longitude
    }
    
    init(id: UUID, title: String, date: Date, images: Set<String>, bookmarks: Int, activities: Set<Activity>, locationCoordinates: LocationCoordinates) {
        self.id = id
        self.title = title
        self.date = date
        self.images = images
        self.bookmarks = bookmarks
        self.activities = activities
        self.locationCoordinates = locationCoordinates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        
        let dateString = try container.decode(String.self, forKey: .date)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        self.date = date
        
        images = try container.decode(Set<String>.self, forKey: .images)
        bookmarks = try container.decode(Int.self, forKey: .bookmarks)
        activities = try container.decode(Set<Activity>.self, forKey: .activities)
        
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        locationCoordinates = LocationCoordinates(lat: latitude, long: longitude)
    }
}
