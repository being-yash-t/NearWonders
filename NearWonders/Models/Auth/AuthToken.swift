//
//  AuthToken.swift
//  NearWonders
//
//  Created by Jay Thakur on 17/06/24.
//

import Foundation

struct AuthToken: Codable {
    let token: String;
    let refreshToken: String;
    let user: User;
    
    
    enum CodingKeys: String, CodingKey {
        case token = "access"
        case refreshToken = "refresh"
        case user = "user"
    }
}
