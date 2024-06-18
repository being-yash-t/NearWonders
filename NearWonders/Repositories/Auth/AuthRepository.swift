//
//  AmplifyAuth.swift
//  NearWonders
//
//  Created by Jay Thakur on 01/01/24.
//

import Foundation
import Combine

enum SignUpStep {
    case verificationPending
    case signedIn
}

protocol AuthRepositoryProtocol {
    var signInStateChange: CurrentValueSubject<Bool, Never> { get }
    
    func currentUser() -> User?
    func signUp(username: String, password: String, firstName: String, lastName: String) async throws -> SignUpStep
    func verifySignUp(for username: String, with confirmationCode: String) async throws
    func signIn(username: String, password: String) async throws
    func signOut() async throws
    func deleteAccount() async
}

class AuthRepository: AuthRepositoryProtocol {
    
    var signInStateChange = CurrentValueSubject<Bool, Never>(false)
    
    private init() {}
    
    static let shared = AuthRepository()

    func currentUser() -> User? {
        do {
            let user: User = try KeychainHelper.shared.get(forKey: .user)
            signInStateChange.send(true)
            return user
        } catch let error as KeychainError {
            print("Failed to read keys \(error.localizedDescription)")
        } catch let error {
            print("Unknown Auth error \(error.localizedDescription)")
        }
        signInStateChange.send(false)
        return nil
    }
    
    func signUp(username: String, password: String, firstName: String, lastName: String) async throws -> SignUpStep {
        // Implement sign-up logic here
        let loginRequest = [
            "username": username,
            "password": password,
            "first_name": firstName,
            "last_name": lastName
        ]
        let result = await withCheckedContinuation { continuation in
            APIClient.shared.post(to: AuthConstants.login, body: loginRequest) { (result: Result<AuthToken, Error>) in
                continuation.resume(returning: result)
            }
        }
        
        
        switch result {
        case .success(let authToken):
            try saveAuthToken(authToken: authToken)
            signInStateChange.send(true)
            return .signedIn;
        case .failure(let error):
            throw error
        }
    }
    
    func verifySignUp(for username: String, with confirmationCode: String) async throws {
        // Implement sign-up verification logic here
    }
    
    func signIn(username: String, password: String) async throws {
        let loginRequest = ["username": username, "password": password]
        let result = await withCheckedContinuation { continuation in
            APIClient.shared.post(to: AuthConstants.login, body: loginRequest) { (result: Result<AuthToken, Error>) in
                continuation.resume(returning: result)
            }
        }
        
        switch result {
        case .success(let authToken):
            try saveAuthToken(authToken: authToken)
            signInStateChange.send(true)
        case .failure(let error):
            throw error
        }
    }
    
    private func saveAuthToken(authToken: AuthToken) throws {
        do {
            try KeychainHelper.shared.save(authToken.token, forKey: .userToken)
            try KeychainHelper.shared.save(authToken.refreshToken, forKey: .userRefreshToken)
            try KeychainHelper.shared.save(authToken.user, forKey: .user)
            print("User saved successfully")
        } catch let error as KeychainError {
            print("User saving failed \(error)");
            throw AuthenticationError.unknown(message: "Data saving failed")
        }
    }
    
    func signOut() async throws {
        do {
            try KeychainHelper.shared.delete(forKey: .userToken)
            try KeychainHelper.shared.delete(forKey: .userRefreshToken)
            try KeychainHelper.shared.delete(forKey: .user)
            self.signInStateChange.send(false)
        } catch let error as KeychainError {
            print("Failed to clear auth data \(error.localizedDescription)")
            throw AuthenticationError.unknown(message: "Failed to clear data")
        }
    }
    
    func deleteAccount() async {
//        let result = await withCheckedContinuation { continuation in
//            APIClient.shared.post(to: AuthConstants.deleteAccount, body: <Docodable>[]) { (result: Result<AuthToken, Error>) in
//                continuation.resume(returning: result)
//            }
//        }
//        
//        switch result {
//        case .success():
//            self.signInStateChange.send(false)
//        case .failure(let error):
//            throw error
//        }
    }
}
