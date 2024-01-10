//
//  NearWondersApp.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI
import Amplify
import AWSCognitoAuthPlugin

@main
struct NearWondersApp: App {
    
    @StateObject var authViewModel = AuthViewModel(repository: AuthRepository.shared)
    
    init() {
        do {
            try Amplify.add(plugin: AWSCognitoAuthPlugin())
            try Amplify.configure()
            print("Amplify configured with auth plugin")
        } catch {
            print("Failed to initialize Amplify with \(error)")
        }
    }
    
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
