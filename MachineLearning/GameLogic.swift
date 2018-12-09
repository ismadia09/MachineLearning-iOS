//
//  GameLogic.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation


class GameLogic {
    var operations : [Operation] = []
    func generateOperations(nbOfOperations : Int){
        while nbOfOperations >= 0 {
            let firstOperand = Int.random(in: 0..<100)
            let secondOperand = Int.random(in: 0..<100)
            let sign = "+-/*".randomElement()
            //let operation = Operation(firstOperand: firstOperand, secondOperand: secondOperand, sign: sign!)
            //operations.append(operation)
        }
        
    }
}
