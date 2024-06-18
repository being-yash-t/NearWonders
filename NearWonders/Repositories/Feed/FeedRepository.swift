//
//  FeedRepository.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/06/24.
//

import Foundation

protocol FeedRepositoryProtocol {
    func loadFeed() async throws -> [LocationSummary]
}

class FeedRepository : FeedRepositoryProtocol {
    
    private init() {}
    
    static let shared = FeedRepository()
    
    func loadFeed() async throws -> [LocationSummary] {
        let result = await withCheckedContinuation { continuation in
            APIClient.shared.get(from: UserActivityConstants.locationSummary) { (result: Result<[LocationSummary], Error>) in
                continuation.resume(returning: result)
            }
        }
        
        switch result {
        case .success(let items):
            return items
        case .failure(let error):
            throw error
        }
    }
}
