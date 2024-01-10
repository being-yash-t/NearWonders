//
//  Errors.swift
//  NearWonders
//
//  Created by Jay Thakur on 31/12/23.
//

import Foundation
import Amplify

enum GenericError: Error {
    case failedToParseUrl
    case failedToParseData
    case canOpenUrlFailed
}

enum AuthenticationError: Error {
    case invalidCredentials
    case noUserSignedIn
    case unknown(message: String?)
    
    public var message: String {
        switch self {
        case .invalidCredentials:
            return "Invalid Credentials"
        case .noUserSignedIn:
            return "No user signed in"
        case .unknown(let message):
            return message ?? "Unknown"
        }
    }
}

class ErrorMessage {
    static func from(_ error : any Error) -> String {
        if error is AuthenticationError {
            return (error as! AuthenticationError).message
        } else { return error.localizedDescription }
    }
}
