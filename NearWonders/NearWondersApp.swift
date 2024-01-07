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
    
    @StateObject var authViewModel: AuthViewModel = AuthViewModel()
    
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
            (authViewModel.isSignedIn ? AnyView(HomeScreen()) : AnyView(LoginScreen()))
                .environmentObject(authViewModel)
                .onAppear { LocationManager.shared.requestLocationAuthorization() }
        }
    }
}
