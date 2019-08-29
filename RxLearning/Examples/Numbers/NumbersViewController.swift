//
//  NumbersViewController.swift
//  RxLearning
//
//  Created by Buck on 2019/8/29.
//  Copyright © 2019 Buck. All rights reserved.
//

import UIKit

class NumbersViewController: ViewController {

    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            Observable.combineLatest(tf1.rx.text.orEmpty, tf2.rx.text.orEmpty, tf3.rx.text.orEmpty) { (value1, value2, value3) -> Int in
                    return value1.toInt() + value2.toInt() + value3.toInt()
            }
            .map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        
    }

}

extension String {
    func toInt() -> Int {
        return Int(self) ?? 0
    }
}
