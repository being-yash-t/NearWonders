//
//  AuthModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 01/01/24.
//

import Foundation
import Combine

@MainActor
class AuthViewModel: ObservableObject {
    let repository: AuthRepositoryProtocol
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var isSignedIn: Bool = false
    
    @Published var user: User?
    
    fileprivate func setupSignedInStatus() {
        user = repository.currentUser()
        isSignedIn = user != nil
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
    }
    
    func currentUser() async {
        user = repository.currentUser()
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
