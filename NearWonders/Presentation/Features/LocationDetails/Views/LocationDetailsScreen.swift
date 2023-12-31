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
    let locationSummary: LocationSummary
    @ObservedObject var viewModel: LocationDetailsViewModel
    
    init(for locationSummary: LocationSummary) {
        self.locationSummary = locationSummary
        self.viewModel = LocationDetailsViewModel(loadFor: locationSummary)
    }
    
    var body: some View {
        if let details = viewModel.details {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    CarouselWithMap(
                        mapTitle: "",
                        images: details.previewImages,
                        locationCoordinates: details.locationCoordinates
                    )
                    Overview(details: details)
                    Feed()
                }
            }
            .navigationTitle(locationSummary.title)
            .toolbar {
                ToolbarItem {
                    Button(action: { lauchDirections(for: details.locationCoordinates) }) {
                        Image(systemName: "location")
                    }
                }
            }
        } else {
            ProgressView()
        }
    }
    
    private func lauchDirections(for locationCoordinates: LocationCoordinates) {
        do {
            try URLLauncher.mapDirections(for: locationCoordinates.coordinates)
        } catch { // TODO: show message if failed
            print(error)
        }
    }
}

#Preview {
    NavigationView {
        LocationDetailsScreen(for: mockLocationSummary1)
    }
}

struct Overview: View {
    let details: LocationDetails
    
    var body: some View {
        VStack(alignment: .leading) {
            if details.description != nil {
                Text("About").font(.headline).padding(.horizontal).padding(.vertical, 8)
                Text(details.description!).font(.subheadline).foregroundStyle(.primary.opacity(0.8))
                    .padding([.horizontal, .bottom])
            }
            
            Text("Activities").font(.headline).padding(.horizontal).padding(.bottom, 4)
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
    }
}

struct CarouselWithMap: View {
    let mapTitle: String
    let images: Set<String>
    let locationCoordinates: LocationCoordinates
    
    @State var camera: MapCameraPosition = .automatic
    
    init(mapTitle: String, images: Set<String>, locationCoordinates: LocationCoordinates) {
        self.mapTitle = mapTitle
        self.images = images
        self.locationCoordinates = locationCoordinates
        self.camera = .region(.init(
                center: locationCoordinates.coordinates,
                latitudinalMeters: 10000,
                longitudinalMeters: 10000
       ))
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(images.sorted(), id: \.self) {
                    ImagePreview(imageUrl: $0, size: kPreviewSize, cornerRadius: 0)
                }
                Map(position: $camera, interactionModes: [.pitch, .zoom]) {
                    Marker(mapTitle, coordinate: locationCoordinates.coordinates)
                }
                .mapStyle(.imagery)
                .frame(width: kPreviewSize, height: kPreviewSize)
            }
        }
    }
}

struct Feed: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Divider()
            Text("Posts").font(.headline).padding([.horizontal, .top]).padding(.bottom, 8)
            ForEach(1..<5) { id in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 24, height: 24)
                            .clipShape(.circle)
                            .foregroundColor(.gray)
                        Text("User Name").font(.caption).foregroundStyle(.primary.opacity(0.8))
                    }
                    .padding(.bottom, 8)
                    .padding(.horizontal)
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(mockLocationSummary2.images.sorted(), id: \.self) { url in
                                ImagePreview(imageUrl: url, size: 80, cornerRadius: 4)
                            }
                        }.padding(.horizontal)
                    }
                    
                    Text(id % 3 != 0
                         ? "Louream Ipsum! adklsf aklsdf;kas;df ;asdf"
                         : "Louream Ipsum! adklsf aklsdf;la sdf l;asdf l;asdf ;asdfs l;fals;df kas;df ;asdf")
                    .font(.subheadline)
                    .padding(.horizontal)
                }
                
                Divider()
            }.padding(.vertical, 8)
        }
    }
}
