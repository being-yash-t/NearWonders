//
//  HomeScreenViewModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/06/24.
//

import Foundation

@MainActor
class HomeScreenViewModel: ObservableObject {
    
    let repository: FeedRepositoryProtocol

    @Published var isLoading = true
    @Published var data: [LocationSummary] = []
    @Published var selectedLocation: LocationSummary?
    @Published var errorMessage: String? = nil
    @Published var mapView : Bool = false

    init() {
        repository = FeedRepository.shared
        Task { await loadItems(mapView: false) }
    }
    
    
    func loadItems( mapView: Bool) async {
        isLoading = true
        defer { isLoading = false }
        do {
            self.mapView = mapView
            data = try await repository.loadFeed()
        } catch let error {
            errorMessage = error.localizedDescription
        }
    }
}
