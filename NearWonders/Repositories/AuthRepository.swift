//
//  AmplifyAuth.swift
//  NearWonders
//
//  Created by Jay Thakur on 01/01/24.
//

import Foundation
import Amplify
import AWSCognitoAuthPlugin

enum SignUpStep {
    case verificationPending
    case signedIn
}

protocol AuthRepositoryProtocol {
    var isSignedIn: Bool { get }
    
    func currentUser() async throws -> User
    func saveUserAttribute(name: String?, gender: Gender?) async throws 
    func signUp(username: String, password: String, email: String) async throws -> SignUpStep
    func verifySignUp(for username: String, with confirmationCode: String) async throws
    func signIn(username: String, password: String) async throws
    func signOut() async throws
}

final class AuthRepository: AuthRepositoryProtocol {
    
    private(set) var isSignedIn: Bool {
        get { UserDefaults.standard.bool(forKey: UserDefaultsKey.isUserLoggedIn.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: UserDefaultsKey.isUserLoggedIn.rawValue) }
    }
    
    func updateSignInStatus() async {
        let result = try? await Amplify.Auth.fetchAuthSession()
        isSignedIn = result?.isSignedIn ?? false
    }
    
    fileprivate func authenticationError(_ error: AuthError) -> AuthenticationError {
        print(error)
        if case .signedOut(_, _, _) = error {
            return AuthenticationError.noUserSignedIn
        } else if case .sessionExpired(_, _, _) = error {
            return AuthenticationError.noUserSignedIn
        } else {
            return AuthenticationError.unknown
        }
    }
    
    func saveUserAttribute(
        name: String?,
        gender: Gender?
    ) async throws {
        var attributes: [AuthUserAttribute] = []
        if name != nil {
            attributes.append(AuthUserAttribute(.name, value: name!))
        }
        if gender != nil {
            attributes.append(AuthUserAttribute(.gender, value: gender!.rawValue))
        }
        do {
            let updateResults = try await Amplify.Auth.update(userAttributes: attributes)
            let updatePendingResults = updateResults.filter { !$0.value.isUpdated }
            updatePendingResults.forEach { (key: AuthUserAttributeKey, value: AuthUpdateAttributeResult) in
                print("Attribute Update Not Completed for: \(key.rawValue)", "Reason: \(value.nextStep)")
            }
        } catch let error as AuthError {
            throw authenticationError(error)
        } catch {
            print("Unexpected error: \(error)")
            throw AuthenticationError.unknown
        }
    }
    
    func currentUser() async throws -> User {
        do {
            let session = try await Amplify.Auth.fetchAuthSession()
            guard session.isSignedIn else { throw AuthenticationError.noUserSignedIn }
            let attributes = try await Amplify.Auth.fetchUserAttributes()
            
            var email: String?
            var id: String?
            
            for attribute in attributes {
                print("\(attribute.key): \(attribute.value)")
                if email != nil && id != nil {
                    break
                } else if attribute.key == .sub {
                    id = attribute.value
                } else if attribute.key == .email {
                    email = attribute.value
                }
            }
            guard email != nil || id != nil else { throw GenericError.failedToParseData }
            
            return User(email: email!, id: id!, name: nil)
        } catch let error as AuthError {
            throw authenticationError(error)
        } catch {
            print("Unexpected error: \(error)")
            throw AuthenticationError.unknown
        }
    }
    
    func signUp(username: String, password: String, email: String) async throws -> SignUpStep {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        do {
            let signUpResult = try await Amplify.Auth.signUp(username: username, password: password, options: options)
            
            switch signUpResult.nextStep {
            case .confirmUser(_, _, _):
                return .verificationPending
            case .done:
                await updateSignInStatus()
                return .signedIn
            }
        } catch let error as AuthError {
            throw authenticationError(error)
        } catch {
            print("Unexpected error: \(error)")
            throw AuthenticationError.unknown
        }
    }

    func verifySignUp(for username: String, with confirmationCode: String) async throws {
        do {
            let confirmSignUpResult = try await Amplify.Auth.confirmSignUp(
                for: username,
                confirmationCode: confirmationCode
            )
            if confirmSignUpResult.isSignUpComplete {
                await updateSignInStatus()
            } else {
                print("VerifySignUp: isSignUpComplete returned false after verification", confirmSignUpResult.nextStep)
                throw NSError()
            }
        } catch let error as AuthError {
            throw authenticationError(error)
        } catch {
            print("Unexpected error: \(error)")
            throw AuthenticationError.unknown
        }
    }
    
    func signIn(username: String, password: String) async throws {
        do {
            let signInResult = try await Amplify.Auth.signIn(username: username, password: password)
            
            if signInResult.isSignedIn {
                isSignedIn = true
            } else {
                print("signIn: isSignedIn returned false", String(describing: signInResult.nextStep))
                throw NSError()
            }
        } catch let error as AuthError {
            throw authenticationError(error)
        } catch {
            print("Unexpected error: \(error)")
            throw AuthenticationError.noUserSignedIn
        }
    }
    
    func signOut() async throws {
        let result = await Amplify.Auth.signOut()
        guard let signOutResult = result as? AWSCognitoSignOutResult
        else {
            print("Signout failed")
            throw AuthenticationError.unknown
        }
        await updateSignInStatus()
        
        switch signOutResult {
        case .complete:
            // Sign Out completed fully and without errors.
            print("Signed out successfully")
            
        case let .partial(revokeTokenError, globalSignOutError, hostedUIError):
            // Sign Out completed with some errors. User is signed out of the device.
            if let hostedUIError = hostedUIError {
                print("HostedUI error  \(String(describing: hostedUIError))")
            }
            if let globalSignOutError = globalSignOutError {
                // Optional: Use escape hatch to retry revocation of globalSignOutError.accessToken.
                print("GlobalSignOut error  \(String(describing: globalSignOutError))")
            }
            if let revokeTokenError = revokeTokenError {
                // Optional: Use escape hatch to retry revocation of revokeTokenError.accessToken.
                print("Revoke token error  \(String(describing: revokeTokenError))")
            }
            
        case .failed(let error):
            print("SignOut failed with \(error)")
            throw authenticationError(error)
        }
    }
}
