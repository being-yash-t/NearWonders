//
//  HomeScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import Foundation

struct HomeScreen: View {
    @State var mapView = false
    @State var profileVisible = false
    @State var selectedLocation: LocationSummary?
    @State var data: [LocationSummary] = [
        mockLocationSummary1,
        mockLocationSummary2,
        mockLocationSummary3
    ]
    @State var newUserActivityVisible = false
    
    var body: some View {
        let view = mapView
        ? AnyView(MapScreen(data: $data, selectedLocation: $selectedLocation))
        : AnyView(FeedScreen(data: $data, selectedLocation: $selectedLocation))
        
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                view
                    .navigationTitle(mapView ? "Map" : "Feed")
                    .navigationBarTitleDisplayMode(mapView ? .inline : .automatic)
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(
                                action: { profileVisible.toggle() },
                                label: { Image(systemName: "person.crop.circle") }
                            )
                        }
                    })
                VStack {
                    Button(
                        action: { mapView.toggle() },
                        label: { Image(systemName: mapView ? "map.fill": "map") }
                    )
                    .padding([.top, .horizontal])
                    .padding(.bottom, 8)
                    
                    Divider().frame(width: 32)
                    
                    Button(
                        action: { newUserActivityVisible.toggle() },
                        label: { Image(systemName: "plus.viewfinder") }
                    )
                    .padding([.bottom, .horizontal])
                    .padding(.top, 8)
                }
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 50))
                .padding(.trailing)
            }
            .sheet(isPresented: $newUserActivityVisible) { NewUserActivityScreen() }
            .sheet(isPresented: $profileVisible) { ProfileScreen() }
        }
    }
}

#Preview {
    HomeScreen()
}
