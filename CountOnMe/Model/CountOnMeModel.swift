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
    var displayResult = ""
    var alertText = "Y'a quoi"
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
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"{
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
        if elements.last != "+" && elements.last != "-"  && elements.last != "x" && elements.last != "/"{
            return true
        }else if expressionHaveResult{
            return true
        }else{
            alertText = AlertText.AlertCases.haveAlreadyOperator.rawValue
        }
        return false
    }
    

    // Add decimal
    func addDecimal(element: String) {
        if isAutorizingDecimal() {
//            elements.append(element)
        }
    }
    
    var isDecimal: Bool{
        return calculText.contains(".")
    }
    
    func isAutorizingDecimal()-> Bool {
        if elements.last == "." {
            return false
        }
        return true
    }
    
    
    // Clear elements
    func clearAllElements() {
     calculText = ""
    }
    
    // MAKE THE CALCUL
    func makeCalcul() -> String? {
        
        
        // Create local copy of operations
        var operationsToReduce = elements
        var index = 0
        guard let left = Double(operationsToReduce[index]), let right = Double(operationsToReduce[index+2]) else { return "ERREUR" }
        let operand = operationsToReduce[index+1]
        var result: Double = 0
        
    
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            
            if isPriorityCalcul(subCalcul : operationsToReduce){
                            if operand != "/" && operand != "*"{
                                index += 2
                                continue
                            }
                        }
            
            switch operand {
            case "+":
                result = left + right
            case "-":
                result = left - right
            case "x":
                result = left * right
            case "/":
                result = left / right
            default: fatalError("Operateur inconnu !")
            }
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: index)
                                                
            index = 0
            
        }//end of while
        return operationsToReduce.first
    }
    
    // Check if there is prioritory operator
    func isPriorityCalcul(subCalcul : [String]) -> Bool{
                return subCalcul.contains("/") || subCalcul.contains("*")
            }


}

