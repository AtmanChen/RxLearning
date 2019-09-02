//
//  GitHubSignupViewModel1.swift
//  RxLearning
//
//  Created by Buck on 2019/9/2.
//  Copyright © 2019 Buck. All rights reserved.
//

import Foundation


final class GitHubViewModel1 {

    // outputs {

    let validatedUsername: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    let validatedRepeatPassword: Driver<ValidationResult>

    let signupEnabled: Driver<Bool>
//    let signedIn: Driver<Bool>
//    let signingIn: Driver<Bool>

    //
    
    
    init(
        input:(
            username: Driver<String>,
            password: Driver<String>,
            repeatedPassword: Driver<String>,
            loginTaps: Signal<Void>
        ),
        validationService: GitHubValidationService
    ) {
        validatedUsername = input.username
            .map { username in
                return validationService.validateUsername(username)
            }
        
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
            }
        
        validatedRepeatPassword = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
        
//        let usernameAndPassword = Driver.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
//        let signingIn = ActivityIndicator()
//        self.signingIn = signingIn.asDriver()
        
        signupEnabled = Driver.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedRepeatPassword
        ) { username, password, repeatedPassword in
            username.isValid && password.isValid && repeatedPassword.isValid
        }
            .distinctUntilChanged()
        
    }

}
