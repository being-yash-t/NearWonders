//
//  User.swift
//  NearWonders
//
//  Created by Jay Thakur on 14/06/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let fullName: String
    let email: String
    let userSince: Date

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case email
        case userSince = "user_since"
    }
    
    init(id: Int, fullName: String, email: String, userSince: Date) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.userSince = userSince
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        fullName = try container.decode(String.self, forKey: .fullName)
        email = try container.decode(String.self, forKey: .email)
        
        // Attempt to decode userSince as a String first
        if let dateString = try? container.decode(String.self, forKey: .userSince) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            if let date = formatter.date(from: dateString) {
                userSince = date
            } else {
                throw DecodingError.dataCorruptedError(forKey: .userSince, in: container, debugDescription: "Date string does not match format expected by formatter.")
            }
        } else if let timestamp = try? container.decode(Double.self, forKey: .userSince) {
            userSince = Date(timeIntervalSince1970: timestamp)
        } else {
            throw DecodingError.dataCorruptedError(forKey: .userSince, in: container, debugDescription: "Date value is neither a valid String nor a Double timestamp.")
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(email, forKey: .email)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        let dateString = formatter.string(from: userSince)
        try container.encode(dateString, forKey: .userSince)
    }
}
