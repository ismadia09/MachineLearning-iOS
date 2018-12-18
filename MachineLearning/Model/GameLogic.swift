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
        var i = 0
        while  i < nbOfOperations {
            let signTab : [String] = ["+","-","/","*"]
            let sign = signTab[Int.random(in: 0..<signTab.count - 1)]
            let firstOperand = Int.random(in: 0..<100)
            var secondOperand = Int.random(in: 0..<100)
            // avoir des resultat strictements positifs lors des soustractions
            while (secondOperand > firstOperand && sign.elementsEqual("-")) {
                secondOperand = Int.random(in: 0..<100)
            }
            
            let operation = Operation(firstOperand: firstOperand, secondOperand: secondOperand, sign: sign)
            operations.append(operation)
            i = i + 1
        }
        
    }
}
