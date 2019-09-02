//
//  DefaultImplementations.swift
//  RxLearning
//
//  Created by Buck on 2019/9/2.
//  Copyright © 2019 Buck. All rights reserved.
//

import struct Foundation.CharacterSet
import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.NSRange
import class Foundation.URLSession
import func Foundation.arc4random


final class GitHubDefaultValidationService: GitHubValidationService {
    
    static let sharedValidationService = GitHubDefaultValidationService()
    
    private init() {}
    
    let minPasswordCount = 5
    
    func validateUsername(_ username: String) -> ValidationResult {
        if username.isEmpty {
            return .empty
        }
        
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .failed(message: "Username can only contain numbers or digits")
        }
        
        return .ok(message: "Username available")
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let passwordCount = password.count
        if passwordCount == 0 {
            return .empty
        }
        if passwordCount < minPasswordCount {
            return .failed(message: "Password must be at least \(minPasswordCount) characters")
        }
        return .ok(message: "Password acceptable")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "Password repeated")
        } else {
            return .failed(message: "Password different")
        }
    }
    
}

