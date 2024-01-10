//
//  AuthModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 01/01/24.
//

import Foundation
import Combine
import Amplify

@MainActor
class AuthViewModel: ObservableObject {
    let repository: AuthRepositoryProtocol
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var isSignedIn: Bool = false 
    
    @Published var user: User?
    
    fileprivate func setupSignedInStatus() {
        isSignedIn = repository.isSignedIn
        repository.signInStateChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self else { return }
                
                if self.isSignedIn != $0 {
                    self.isSignedIn = $0
                    if $0 { Task { await self.currentUser() } }
                    else { self.user = nil }
                }
            }
            .store(in: &cancellables)
    }
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
        setupSignedInStatus()
        if isSignedIn && user == nil {
            Task { await currentUser() }
        }
    }
    
    func currentUser() async {
        do {
            user = try await repository.currentUser()
        } catch {
            print("Failed to fetch user data")
        }
    }
    
    func signOut() async {
        do {
            try await repository.signOut()
        } catch {
            print("Failed to signOut")
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
