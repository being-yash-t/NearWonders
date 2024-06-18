//
//  LocationDetailsViewModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 28/12/23.
//

import Foundation

class LocationDetailsViewModel: ObservableObject {
    @Published var details: LocationDetails?
    
    init(loadFor location: LocationSummary) {
        details = LocationDetails(
            title: location.title,
            description: "Test Description",
            locationCoordinates: location.locationCoordinates,
            activities: [.Camp, .OffRoadTrail],
            bestSeasons: [Season.Spring, Season.Autumn],
            previewImages: mockLocationSummary1.images
        )
    }
}
