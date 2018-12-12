//
//  Numbers.swift
//  MachineLearning
//
//  Created by Ismaël Diallo on 12/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation

class Number {
    let image : String
    let type : String
    let expectedResult : Int
    
    init(image : String, type : String, expectedResult : Int) {
        self.image = image
        self.type = type
        self.expectedResult = expectedResult
    }
}
