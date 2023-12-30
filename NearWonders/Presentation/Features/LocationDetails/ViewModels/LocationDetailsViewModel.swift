//
//  LocationDetailsViewModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 28/12/23.
//

import Foundation

enum LocationDetailsTab: CaseIterable {
    case overview
    case feed
    case pictures
    
    var name: String {
        switch (self) {
        case .overview:
            "Overview"
        case .feed:
            "Feed"
        case .pictures:
            "Pictures"
        }
    }
}

class LocationDetailsViewModel: ObservableObject {
    @Published var details: LocationDetails?
    
    @Published var selectedTab: LocationDetailsTab = .overview
    
    init(loadFor location: LocationSummary) {
        details = LocationDetails(
            title: location.title,
            description: "Test Description",
            locationCoordinates: location.locationCoordinates,
            activities: [campingActivity, ridingActivity],
            bestSeasons: [Season.Spring, Season.Autumn],
            previewImages: mockLocationSummary1.images
        )
    }
}
