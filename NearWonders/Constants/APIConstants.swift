//
//  APIConstants.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/06/24.
//

import Foundation

protocol APIConstant {
    var rawValue: String { get }
}

enum AuthConstants: String, APIConstant {
    case login = "login/"
    case register = "register/"
    case deleteAccount = "delete-user/"
    // Add other auth-related constants
}

enum UserActivityConstants: String, APIConstant {
    case locationSummary = "locations/"
}
