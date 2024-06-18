//
//  HomeScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import Foundation

struct HomeScreen: View {
    @State var profileVisible = false
    @State var newUserActivityVisible = false
    
    @StateObject var viewModel: HomeScreenViewModel = .init()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    if viewModel.errorMessage != nil && !viewModel.errorMessage!.isEmpty {
                        Spacer()
                        Text("Failed to get data").font(.callout).padding(.bottom, 8)
                        Text(viewModel.errorMessage!).font(.caption).multilineTextAlignment(.center)
                        Spacer()
                    } else if viewModel.mapView {
                        MapScreen(data: $viewModel.data, selectedLocation: $viewModel.selectedLocation)
                            .transition(.slide)
                    } else {
                        FeedScreen(data: $viewModel.data, selectedLocation: $viewModel.selectedLocation)
                            .transition(.slide)
                    }
                }
                .navigationTitle(viewModel.mapView ? "Map" : "Feed")
                    .navigationBarTitleDisplayMode(viewModel.mapView ? .inline : .automatic)
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
                        action: { viewModel.mapView.toggle() },
                        label: { Image(systemName: viewModel.mapView ? "map.fill": "map") }
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
