//
//  Model.swift
//  BMICalculator
//
//  Created by Austen Mack on 4/20/20.
//  Copyright © 2020 Austen Mack. All rights reserved.
//

import Foundation

class Model {
    var Result: CallResult
    
    func addCallResult(b: Double, m: [String], r: String){
        Result = CallResult(b:b, m:m[0], r:r)
    }
    
    init() {
        let initDefault = CallResult(b:24, m: "https://www.cdc.gov/healthyweight/assessing/bmi/index.html", r:"You are normal :)" )
        Result = initDefault
    }
}
