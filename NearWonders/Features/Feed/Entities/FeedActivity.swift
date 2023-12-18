//
//  FeedActivity.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import Foundation

struct FeedActivity: Equatable, Identifiable {
    let id: String
    let title: String
    let date: Date
    let images: Set<String>
    let bookmarks: Int
    let activities: Set<Activity>
    
    static func ==(lhs: FeedActivity, rhs: FeedActivity) -> Bool {
        lhs.id == rhs.id && lhs.title == rhs.title && lhs.date == rhs.date && lhs.images == rhs.images && lhs.bookmarks == rhs.bookmarks && lhs.activities == rhs.activities
    }
}
