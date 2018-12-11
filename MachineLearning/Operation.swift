//
//  Operation.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation

class Operation{
    var firstOperand : Int
    var secondOperand : Int
    var sign : String
    var result : Int
    var operationString : String
    
    init(firstOperand : Int = 1, secondOperand: Int = 1,sign: String = "+") {
        self.firstOperand = firstOperand
        self.secondOperand = secondOperand
        self.sign = sign
        self.result = 0
        self.operationString = "\(firstOperand) \(sign) \(secondOperand)=?"
    }
    
    func getResult() -> Int{
        switch sign {
        case "+":
            self.result = firstOperand + secondOperand
            return firstOperand + secondOperand
        case "-":
            self.result = firstOperand - secondOperand
            return firstOperand - secondOperand
        case "x":
            self.result = firstOperand * secondOperand
            return firstOperand * secondOperand
        case "*":
            self.result = firstOperand * secondOperand
            return firstOperand * secondOperand
        case "/":
            self.result = firstOperand / secondOperand
            return firstOperand / secondOperand
        default:
            return -1
        }
    }
    
}
