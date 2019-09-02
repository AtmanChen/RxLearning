//
//  SignalTestViewController.swift
//  RxLearning
//
//  Created by Buck on 2019/9/2.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class SignalTestViewController: ViewController {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultCountLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let state: Driver<String?> = textfield.rx.text.asDriver()
        let observer = resultLabel.rx.text
        state.drive(observer).disposed(by: disposeBag)
        
        button.rx.tap.withLatestFrom(state)
            .asDriver(onErrorJustReturn: "")
            .map { ($0 ?? "").count }
            .map { $0.description }
            .drive(resultCountLabel.rx.text)
            .disposed(by: disposeBag)
        
    }

}
