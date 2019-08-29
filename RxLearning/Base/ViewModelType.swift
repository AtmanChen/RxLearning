//
//  ViewModelType.swift
//  RxLearning
//
//  Created by Buck on 2019/8/29.
//  Copyright © 2019 Buck. All rights reserved.
//

import Foundation


protocol ViewModelType {
    
    associatedtype Input
    associatedtype Ouput
    
    var input: Input { get }
    var output: Ouput { get }
}
