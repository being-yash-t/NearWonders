//
//  AuthModel.swift
//  NearWonders
//
//  Created by Jay Thakur on 01/01/24.
//

import Foundation
import Amplify

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var verificationCode: String = ""
    @Published var step: LoginState = .login
    @Published var errorTitle: String?
    @Published var errorMessage: String?
    
    let repository: AuthRepositoryProtocol
    
    init() {
        self.repository = AuthRepository.shared
    }
    
    init(repository: AuthRepositoryProtocol) {
        self.repository = repository
    }
    
    var validateCredentials: Bool {
        switch step {
        case .registerUser:
            return password == confirmPassword && !email.isEmpty && password.count > 6 && !password.contains(" ") && RegexValidator.shared.validateEmail(email)
        case .login:
            return !email.isEmpty && password.count > 6 && !password.contains(" ") && RegexValidator.shared.validateEmail(email)
        case .verificationPending:
            return !verificationCode.isEmpty && !verificationCode.contains(" ")
        }
    }
    
    func signIn() async {
        do {
            try await repository.signIn(username: email, password: password)
        } catch {
            errorTitle = "Failed to Sign In"
            errorMessage = ErrorMessage.from(error)
        }
    }
    
    func signUp() async {
        do {
            let result = try await repository.signUp(username: email, password: password, email: email)
            switch result {
            case .signedIn:
                break
            case .verificationPending:
                step = .verificationPending
            }
        } catch {
            errorTitle = "Failed to Create account"
            errorMessage = ErrorMessage.from(error)
        }
    }
    
    func verifySignUp() async {
        do {
            try await repository.verifySignUp(for: email, with: verificationCode)
        } catch {
            errorTitle = "Failed to verify"
            errorMessage = ErrorMessage.from(error)
        }
    }


}
