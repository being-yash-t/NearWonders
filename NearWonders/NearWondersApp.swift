//
//  NearWondersApp.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

@main
struct NearWondersApp: App {
    
    @StateObject var authViewModel = AuthViewModel(repository: AuthRepository.shared)
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isSignedIn {
                HomeScreen().onAppear { LocationManager.shared.requestLocationAuthorization() }
            } else {
                LoginScreen()
            }
        }.environmentObject(authViewModel)
    }
}
