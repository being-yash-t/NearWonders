//
//  MapScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    let backwaters = CLLocationCoordinate2D(latitude: 20.020683, longitude: 73.671559)
    let alandiDam = CLLocationCoordinate2D(latitude: 20.114213, longitude: 73.689662)
    let images = exampleFeedActivity.images.sorted()
    
    @State var camera: MapCameraPosition = .automatic
    @State var selectedLocation: String?
    
    
    var body: some View {
        Map(position: $camera, interactionModes: [.pan, .pitch, .zoom]) {
            Annotation("BackWaters", coordinate: backwaters) {
                CImage(images[0]) {
                    selectedLocation = "Backwaters"
                    camera = .region(MKCoordinateRegion(
                        center: backwaters,
                        latitudinalMeters: 200,
                        longitudinalMeters: 200
                    ))
                }
            }
            Annotation("Alandi Dam", coordinate: alandiDam) {
                CImage(images[1]) {
                    selectedLocation = "Alandi Dam"
                    camera = .region(MKCoordinateRegion(
                        center: alandiDam,
                        latitudinalMeters: 200,
                        longitudinalMeters: 200
                    ))
                }
            }
        }
        .safeAreaInset(edge: .top, content: {
            if selectedLocation != nil {
                HStack {
                    Spacer()
                    Text(selectedLocation!)
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

#Preview {
    MapScreen()
}
