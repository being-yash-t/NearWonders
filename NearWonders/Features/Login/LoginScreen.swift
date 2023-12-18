//
//  LoginScreen.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/12/23.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            Image(systemName: "globe")
                .resizable()
                .foregroundColor(.green)
                .frame(width: 200, height: 200)
                .padding()
            Text("NearWonders").font(.largeTitle)
            Text("Unleash the Hidden Gems of Adventure")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.black.opacity(0.8))
            
            Spacer()
            Button( action: { print("Login") }) {
                Text("Login with Google")
                    .frame(maxWidth: .infinity)
            }
            
            Button( action: { print("Login") }) {
                Label("Login with Apple", systemImage: "apple.logo")
                    .frame(maxWidth: .infinity)
            }.accentColor(.black)
            Spacer()
        }
        .frame(width: 250)
        .font(.headline)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    LoginScreen()
}
