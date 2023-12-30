//
//  NearWondersApp.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

@main
struct NearWondersApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeScreen().onAppear { LocationManager.shared.requestLocationAuthorization() }
        }
    }
}
