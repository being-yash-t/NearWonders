//
//  MockData.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import Foundation
//
/// LocationActivity
let mockLocationSummary1 = LocationSummary(
    id: UUID(),
    title: "Bhandardara Dam",
    date: Date(),
    images: [
        "https://images.pexels.com/photos/6638603/pexels-photo-6638603.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/2699258/pexels-photo-2699258.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/1633943/pexels-photo-1633943.jpeg?auto=compress&cs=tinysrgb&w=600"
    ],
    bookmarks: 40,
    activities: [.Camp],
    locationCoordinates: LocationCoordinates(
        lat: 19.54738325316985,
        long: 73.7573012385777
    )
)
let mockLocationSummary2 = LocationSummary(
    id: UUID(),
    title: "Devbag Beach",
    date: Date().addingTimeInterval(-6000),
    images: [
        "https://images.pexels.com/photos/2496880/pexels-photo-2496880.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/1212600/pexels-photo-1212600.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/87812/pexels-photo-87812.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/585759/pexels-photo-585759.jpeg?auto=compress&cs=tinysrgb&w=600"
    ],
    bookmarks: 65,
    activities: [
        .Trek,
        .BikeTrail
    ],
    locationCoordinates: LocationCoordinates(
        lat: 15.968600491744272,
        long: 73.5008954023122
    )
)
let mockLocationSummary3 = LocationSummary(
    id: UUID(),
    title: "Harishchandragad",
    date: Date().addingTimeInterval(-3600000),
    images: [
        "https://images.pexels.com/photos/1365425/pexels-photo-1365425.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/450062/pexels-photo-450062.jpeg?auto=compress&cs=tinysrgb&w=600",
        "https://images.pexels.com/photos/2534618/pexels-photo-2534618.jpeg?auto=compress&cs=tinysrgb&w=600"
    ],
    bookmarks: 65,
    activities: [
        .Camp,
        .OffRoadTrail
    ],
    locationCoordinates: LocationCoordinates(
        lat: 15.968600491744272,
        long: 73.5008954023122
    )
)

let mockLocationActivities = [mockLocationSummary1, mockLocationSummary2, mockLocationSummary3]
