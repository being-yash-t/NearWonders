//
//  MapScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    @Binding var data: [LocationSummary]
    @Binding var selectedLocation: LocationSummary?
    @State var camera: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $camera, interactionModes: [.pan, .pitch, .zoom]) {
            ForEach(data) { item in
                Annotation(item.title, coordinate: item.locationCoordinates.coordinates) {
                    CImage((item.images.count < 1 ? "" : item.images.first!)) {
                        selectedLocation = item
                        camera = .region(MKCoordinateRegion(
                            center: item.locationCoordinates.coordinates,
                            latitudinalMeters: 200,
                            longitudinalMeters: 200
                        ))
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom, content: {
            if selectedLocation != nil {
                HStack {
                    Spacer()
                    Text(selectedLocation!.title)
                    Spacer()
                }
                .padding()
                .background(.thickMaterial)
            }
        })
    }
}

struct CImage: View {
    let url: String
    let onTap: (() -> Void)?
    let size: CGFloat
    
    init(_ url: String, onTap: @escaping () -> Void, size: CGFloat = 50) {
        self.url = url
        self.onTap = onTap
        self.size = size
    }
    
    init(_ url: String, size: CGFloat = 50) {
        self.url = url
        self.onTap = nil
        self.size = size
    }
    
    var body: some View {
        return AsyncImage(url: URL(string: url)) { image in
            if (image.image != nil) {
                image.image!.resizable()
            } else {
                Color.black.opacity(0.2)
            }
        }
        .frame(width: size, height: size)
        .clipShape(.rect(cornerRadius: 8))
        .shadow(radius: 10)
        .if(onTap != nil) { $0.onTapGesture { onTap!() } }
    }
}

//#Preview {
//    MapScreen()
//}
