//
//  FeedScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct FeedScreen: View {
    let feeds = [
        exampleFeedActivity,
        sunsetBeachActivity,
        mountainHikeActivity,
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(feeds) { item in
                        FeedCard(activity: item)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Feed")
        }
    }
}

#Preview {
    FeedScreen()
}
