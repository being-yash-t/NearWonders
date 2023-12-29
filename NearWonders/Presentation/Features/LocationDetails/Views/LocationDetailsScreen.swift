//
//  SwiftUIView.swift
//  NearWonders
//
//  Created by Jay Thakur on 28/12/23.
//

import SwiftUI
import MapKit

let kPreviewSize: CGFloat = 320

struct LocationDetailsScreen: View {
    let location: Location
    
    @ObservedObject var viewModel = LocationDetailsViewModel()
    @State var camera: MapCameraPosition = .automatic
    
    init(for location: Location) {
        self.location = location
        self.camera = .region(.init(center: location.coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000))
        viewModel.loadDetails(for: location)
    }
    
    var details: LocationDetails? { viewModel.details }
    
    var body: some View {
        if details != nil {
            ScrollView {
                VStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack() {
                            ForEach(details!.previewImages.sorted(), id: \.self) {
                                ImagePreview(imageUrl: $0, size: kPreviewSize, cornerRadius: 0)
                            }
                            Map(position: $camera, interactionModes: [.pitch, .zoom]) {
                                Marker(details!.title, coordinate: details!.coordinates)
                            }
                            .mapStyle(.imagery)
                            .frame(width: kPreviewSize, height: kPreviewSize)
                        }
                        //                            .padding()
                    }
                    if details?.description != nil {
                        Text("About").font(.headline).padding(.horizontal).padding(.vertical, 8)
                        Text(details!.description!).font(.subheadline)
                            .padding([.horizontal])
                    }
                    Text("Activities").font(.headline).padding([.top, .horizontal]).padding(.bottom, 4)
                    HStack {
                        Tag(title: trekkingActivity.name, iconUrl: trekkingActivity.icon, color: Color(rgb: trekkingActivity.rgbColor))
                    }
                    .padding([.horizontal])
                    Text("Best Seasons to Visit").font(.headline).padding([.top, .horizontal]).padding(.bottom, 4)
                    HStack {
                        ForEach(Season.allCases) { season in
                            Tag(title: season.name, systemImage: season.icon, color: Color(rgb: season.rgbColor))
                        }
                    }
                    .padding([.horizontal])
                }
            }.navigationTitle(location.title)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            let coordinates = details!.coordinates
                            let url = URL(string: "maps://?saddr=&daddr=\(coordinates.latitude),\(coordinates.longitude)")
                            if UIApplication.shared.canOpenURL(url!) {
                                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                            }
                        } ) {
                            Image(systemName: "location")
                        }
                    }
                }
        }
        
    }
}

#Preview {
    LocationDetailsScreen(for: Location(
        title: "Backwaters",
        description: "Dam View to chill with friends & family",
        lat: 20.021374231646263,
        long: 73.67330484046086
    ))
}
