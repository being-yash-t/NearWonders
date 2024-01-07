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
    case noUserSignedIn
    case signedOut
    case unknown
}
