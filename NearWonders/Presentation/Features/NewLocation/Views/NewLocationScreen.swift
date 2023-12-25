//
//  NewLocation.swift
//  NearWonders
//
//  Created by Jay Thakur on 20/12/23.
//

import SwiftUI
import MapKit

struct NewLocationScreen: View {
    @State var location: Location
    var body: some View {
        Map(interactionModes: .all) {
            Marker(location.title ?? "You Spot :)", coordinate: location.coordinates)
        }
    }
}

#Preview {
    NewLocationScreen(location: Location(title: nil, lat: 19.54738325316985, long: 73.7573012385777))
}
