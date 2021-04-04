//
//  CallResult.swift
//  BMICalculator
//
//  Created by Austen Mack on 4/20/20.
//  Copyright © 2020 Austen Mack. All rights reserved.
//

import Foundation

class CallResult {
    var bmi: Double?
    var more: String?
    var risk: String?
    
    init(b: Double, m: String, r: String) {
        bmi = b
        more = m
        risk = r
    }
}
