//
//  MapScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    @Binding var data: [LocationActivity]
    @Binding var selectedLocation: LocationActivity?
    @State var camera: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $camera, interactionModes: [.pan, .pitch, .zoom]) {
            ForEach(data) { item in
                Annotation(item.title, coordinate: item.location.coordinates) {
                    // TODO: add placeholder
                    CImage((item.images.count < 1 ? "" : item.images.first!)) {
                        selectedLocation = item
                        camera = .region(MKCoordinateRegion(
                            center: item.location.coordinates,
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
    let onTap: () -> Void
    
    init(_ url: String, onTap: @escaping () -> Void) {
        self.url = url
        self.onTap = onTap
    }
    
    var body: some View {
        return AsyncImage(url: URL(string: url)) { image in
            if (image.image != nil) {
                image.image!.resizable()
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(.rect(cornerRadius: 8))
        .shadow(radius: 10)
        .onTapGesture { onTap() }
    }
}

//#Preview {
//    MapScreen()
//}
