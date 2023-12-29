//
//  LocationDetailsViewModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 28/12/23.
//

import Foundation

class LocationDetailsViewModel: ObservableObject {
    @Published var details: LocationDetails?
    
    init() {}
    
    func loadDetails(for location: Location) {
        details = LocationDetails(
            title: location.title,
            description: location.description,
            lat: location.lat,
            long: location.long,
            activities: [campingActivity, ridingActivity],
            bestSeasons: [Season.Spring, Season.Autumn],
            previewImages: mockLocationActivity1.images
        )
    }
}
