//
//  Gender.swift
//  NearWonders
//
//  Created by Jay Thakur on 18/12/23.
//

import Foundation

enum Gender: String {
    case male
    case female
    case nonBinary
    
    init?(rawStringValue: String) {
        if let matchedCase = Gender(rawValue: rawStringValue.lowercased()) {
            self = matchedCase
        } else {
            return nil
        }
    }
}