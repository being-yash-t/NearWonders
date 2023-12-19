//
//  FeedScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct FeedScreen: View {
    @Binding var data: [LocationActivity]
    @Binding var selectedLocation: LocationActivity?
    
    var body: some View {
        ScrollView {
            // TODO: More efficent way for displaying for large data
            // TODO: automatically animate to selectedLocation
            LazyVStack { ForEach(data) { FeedCard(activity: $0) } }
        }
        .listStyle(.plain)
    }
}

//#Preview {
//    FeedScreen(data: Binding(get: mockLocationActivities, set: { _ in }))
//}
