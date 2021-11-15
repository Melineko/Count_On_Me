//
//  CountOnMeModel.swift
//  CountOnMe
//
//  Created by Melissa Briere on 22/10/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class CountOnMeModel {
    
    let result: Double = 0
    var alertText = "Non valide"
    var left = ""
    var right = ""
    var calculText: String = ""
    
    
    // Transforms calculText into an array of Strings
         var elements: [String] {
            return calculText.split(separator: " ").map { "\($0)" }
        }
    
    var expressionHaveResult: Bool {
          return calculText.firstIndex(of: "=") != nil
 }
    

    //MARK: Error check computed variables
    var expressionIsCorrect: Bool {
        print(elements.last as Any)
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.last != "."{
            return true
        }else{
            alertText = AlertText.AlertCases.notCorrectExpression.rawValue
            return false
        }
        
    }
    
    var expressionHaveEnoughElement: Bool {
        if elements.count >= 3 {
            return true
        }else{
            alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
            return false
        }
    }
    
    var canAddOperator: Bool {
        if elements.last != "+" && elements.last != "-"  && elements.last != "x" && elements.last != "/" {
            return true
        }else if expressionHaveResult{
            return true
        }else{
            alertText = AlertText.AlertCases.haveAlreadyOperator.rawValue
        }
        return false
    }
    

    var isDecimal: Bool{
        return calculText.contains(".")
    }
    
    func isJustOneDecimalNumber()-> Bool{
        if elements.count == 3 && isDecimal{
            alertText = AlertText.AlertCases.notCorrectExpression.rawValue
            return true
        }
        return false
    }
    
    
    // Clear elements
    func clearAllElements() {
     calculText = ""
    }
    
    // MAKE THE CALCUL
    func makeCalcul() -> String? {
 
        // Create local copy of operations
        var operationsToReduce = elements
        var result: Double = 0
        var index = 0
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            for indice in 0..<operationsToReduce.count {
                if operationsToReduce[indice].contains("x") || operationsToReduce[indice].contains("/") {
                    index = indice - 1
                    break
                }
            }
            guard let left = Double(operationsToReduce[index]), let right = Double(operationsToReduce[index+2]) else { return "ERREUR" }
            let operand = operationsToReduce[index+1]
            
            
            switch operand {
            case "+":
                result = left + right
            case "-":
                result = left - right
            case "x":
                result = left * right
            case "/":
                result = left / right
            /*case ".":
                let unionDecimale: String = "\(left)"+"\(operand)"+"\(right)"
                if let doubleValue = Double(unionDecimale) {
                    result = doubleValue
                    print("la décimale utilisée = \(doubleValue)")
                }*/
                
            default: fatalError("Operateur inconnu !")
            }
    
            // Supprimer les 3 premier elements à partir de l'index / indice
            for _ in 1...3{
                operationsToReduce.remove(at: index)
            }
            
            operationsToReduce.insert("\(result)", at: index)
                                                
            index = 0
            
        }//end of while
        return operationsToReduce.first
    }
    
 
    
    // ["12", "+", "4", "/", "2"]
    
    // Replace the first index with result
    func startingWithResult(){
        
    }


}

