//
//  NearWondersApp.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

@main
struct NearWondersApp: App {
    
    init() {
        LocationManager.shared.requestLocationAuthorization()
    }
    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
