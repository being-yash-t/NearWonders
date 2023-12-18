//
//  HomeScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        TabView {
            FeedScreen()
                .tabItem { Label("Feed", systemImage: "photo.stack") }
            MapScreen()
                .tabItem { Label("Map", systemImage: "map") }
        }
    }
}

#Preview {
    HomeScreen()
}
