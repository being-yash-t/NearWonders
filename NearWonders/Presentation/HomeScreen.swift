//
//  HomeScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct HomeScreen: View {
    @State var mapView = false
    @State var selectedLocation: LocationActivity?
    @State var data: [LocationActivity] = [
        mockLocationActivity1,
        mockLocationActivity2,
        mockLocationActivity3
    ]
    @State var newUserActivityVisible = false
    
    var body: some View {
        let view = mapView
        ? AnyView(MapScreen(data: $data, selectedLocation: $selectedLocation))
        : AnyView(FeedScreen(data: $data, selectedLocation: $selectedLocation))
        
        NavigationView {
            view
                .navigationTitle(mapView ? "Map" : "Feed")
                .navigationBarTitleDisplayMode(mapView ? .inline : .automatic)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(
                            action: { mapView.toggle() },
                            label: { Image(systemName: mapView ? "map.fill": "map") }
                        )
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        Button(
                            action: { newUserActivityVisible.toggle() },
                            label: { Image(systemName: "plus.viewfinder") }
                        )
                    }
                })
                .sheet(isPresented: $newUserActivityVisible, content: { NewUserActivityScreen() })
        }
    }
}

#Preview {
    HomeScreen()
}
