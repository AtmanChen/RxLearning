//
//  SimpleValidationViewController.swift
//  RxLearning
//
//  Created by Buck on 2019/8/29.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class SimpleValidationViewController: ViewController {

    @IBOutlet weak var tip2: UILabel!
    @IBOutlet weak var tip1: UILabel!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var doButton: UIButton!
    
    
    private let viewModel = ValidationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tf1.rx.text.orEmpty
            .bind(to: viewModel.input.username)
            .disposed(by: disposeBag)
        
        tf2.rx.text.orEmpty
            .bind(to: viewModel.input.password)
            .disposed(by: disposeBag)
        
        doButton.rx.tap
            .bind(to: viewModel.input.doAction)
            .disposed(by: disposeBag)
        
        viewModel.output.usernameEnabled
            .drive(tip1.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.passwordEnabled
            .drive(tip2.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.output.buttonEnabled
            .drive(doButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.output.buttonAlpha
            .drive(doButton.rx.alpha)
            .disposed(by: disposeBag)
    }

}

final class ValidationViewModel: ViewModelType {
    
    let input: Input
    let output: Output
    
    struct Input {
        let username: AnyObserver<String>
        let password: AnyObserver<String>
        let doAction: AnyObserver<Void>
    }
    
    struct Output {
        let usernameEnabled: Driver<Bool>
        let passwordEnabled: Driver<Bool>
        let buttonEnabled: Driver<Bool>
        let buttonAlpha: Driver<CGFloat>
    }
    
    private let usernameSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let passwordSubject = ReplaySubject<String>.create(bufferSize: 1)
    private let doActionSubject = PublishSubject<Void>()
    
    init() {
        
        input = Input(username: usernameSubject.asObserver(),
                      password: passwordSubject.asObserver(),
                      doAction: doActionSubject.asObserver())
        
        let usernameEnabled = usernameSubject
            .distinctUntilChanged()
            .map { $0.count >= 5 }
            .debug()
            .asDriver(onErrorJustReturn: false)
        
        let passwordEnabled = passwordSubject
            .distinctUntilChanged()
            .map { $0.count >= 5 }
            .asDriver(onErrorJustReturn: false)
        
        let buttonEnabled = Driver.combineLatest(usernameEnabled, passwordEnabled) { $0 && $1 }
        
        let buttonAlpha: Driver<CGFloat> = buttonEnabled
            .map { $0 ? 1.0 : 0.4 }
            .asDriver(onErrorJustReturn: 0)
        
        output = Ouput(usernameEnabled: usernameEnabled,
                       passwordEnabled: passwordEnabled,
                       buttonEnabled: buttonEnabled,
                       buttonAlpha: buttonAlpha)
    }
}
