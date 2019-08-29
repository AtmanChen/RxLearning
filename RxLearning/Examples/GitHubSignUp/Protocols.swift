//
//  Protocols.swift
//  RxLearning
//
//  Created by Buck on 2019/8/29.
//  Copyright © 2019 Buck. All rights reserved.
//

import Foundation

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}
