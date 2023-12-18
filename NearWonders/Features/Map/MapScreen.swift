//
//  MapScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    var body: some View {
        Map(interactionModes: .all)
        
    }
}

#Preview {
    MapScreen()
}
