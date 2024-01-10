//
//  Regex.swift
//  NearWonders
//
//  Created by Jay Thakur on 10/01/24.
//

import Foundation

class RegexValidator {
    static let shared = RegexValidator()
    
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func validateEmail(_ email: String) -> Bool {
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
