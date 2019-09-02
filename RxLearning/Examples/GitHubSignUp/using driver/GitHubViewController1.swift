//
//  GitHubViewController1.swift
//  RxLearning
//
//  Created by Buck on 2019/9/2.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class GitHubViewController1: ViewController {
    
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var usernameValidationOutlet: UILabel!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    @IBOutlet weak var repeatePasswordOutlet: UITextField!
    @IBOutlet weak var repeatPasswordValidationOutlet: UILabel!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = GitHubViewModel1(
            input: (username: usernameOutlet.rx.text.orEmpty.asDriver(),
                    password: passwordOutlet.rx.text.orEmpty.asDriver(),
                    repeatedPassword: repeatePasswordOutlet.rx.text.orEmpty.asDriver(),
                    loginTaps: signupButton.rx.tap.asSignal()),
            validationService: GitHubDefaultValidationService.sharedValidationService)
        
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid in
                self?.signupButton.isEnabled = valid
                self?.signupButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.validatedUsername
            .drive(usernameValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .drive(passwordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedRepeatPassword
            .drive(repeatPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
    }
    

    

}
