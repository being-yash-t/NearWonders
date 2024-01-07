//
//  AuthModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 01/01/24.
//

import Foundation
import Amplify

@MainActor
class AuthViewModel: ObservableObject {
    let repository: AuthRepositoryProtocol
    
    @Published var isSignedIn: Bool = false
    
    @Published var user: User?
    
    fileprivate func updateSignInStatus() {
        isSignedIn = repository.isSignedIn
    }
    
    init() {
        self.repository = AuthRepository()
        updateSignInStatus()
        if isSignedIn { Task { await currentUser() } }
    }
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
        updateSignInStatus()
        if isSignedIn { Task { await currentUser() } }
    }
    
    func currentUser() async {
        do {
            user = try await repository.currentUser()
        } catch {
            print("Failed to fetch user data")
            // TODO: notify failed to fetch current user
        }
    }
    
    func signIn(email: String, password: String) async {
        do {
            try await repository.signIn(username: email, password: password)
            updateSignInStatus()
            await currentUser()
            // TODO: notify signin complete
        } catch {
            debugPrint("Failed to SignIn: ", error)
            // TODO: notify signin failed
        }
    }
    
    func signUp(email: String, password: String, onVerificationPending: @escaping () -> Void) async {
        do {
            let result = try await repository.signUp(username: email, password: password, email: email)
            switch result {
            case .signedIn:
                updateSignInStatus()
            case .verificationPending:
                onVerificationPending()
            }
        } catch {
            // TODO: show error to user
        }
    }
    
    func verifySignUp(email: String, verificationCode: String) async {
        do {
            try await repository.verifySignUp(for: email, with: verificationCode)
            if repository.isSignedIn { updateSignInStatus() }
        } catch {
            // TODO: show error to user
        }
    }
    
    func signOut() async {
        do {
            try await repository.signOut()
            updateSignInStatus()
        } catch {
            print("Failed to signout", error)
        }
    }
}
