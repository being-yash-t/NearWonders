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
                    MapImagePreview((item.images.count < 1 ? "" : item.images.first!)) {
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


#Preview {
    MapScreen(
        data: Binding(get: { mockLocationActivities }, set: { _ in}),
        selectedLocation: Binding<LocationSummary?>(get: { nil }, set: { _ in})
    )
}
