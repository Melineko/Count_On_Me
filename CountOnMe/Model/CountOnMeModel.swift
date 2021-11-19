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
    
    
    // MARK: - Error check computed variables
    // Is already a result
    var expressionHaveResult: Bool {
          return calculText.firstIndex(of: "=") != nil
 }
    
    // Check the number of decimal
    func numberOfDecimal() -> Int {
        var decimalCount = 0
        if let lastElement: String = elements.last {
            print(lastElement)
            if lastElement.contains(".") {
            decimalCount += 1
        }
            print("There are \(decimalCount) . last element")// check in console
        }
        return decimalCount
    }
    
    // Check if is already there a decimal
    var isDecimal: Bool {
        if let lastElement = elements.last {
            if lastElement.suffix(1) == "." || numberOfDecimal() > 0 {
            print("\(lastElement)")
            print("isDecimal : true")// check in console
            return true
        }
        print("isDecimal : false")// check in console
        }
        return false
    }

    
    var expressionIsCorrect: Bool {
        print(elements.last as Any)
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && !isDecimal {
            print("expressionIsCorrect : true")// check in console
            return true
        } else {
            alertText = AlertText.AlertCases.notCorrectExpression.rawValue
            print("expressionIsCorrect : false")// check in console
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
            print("canAddOperator : true")// check in console
            return true
        } else {
            print("canAddOperator : false")// check in console
            alertText = AlertText.AlertCases.haveAlreadyOperator.rawValue
        }
        return false
    }
    
    
    // MARK: - Fonctionnalities
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
        
        checkArrayInconsole(in: operationsToReduce)// check in console
        
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
            
            print("Elements après attribution des indexes :")// check in console
            checkArrayInconsole(in: operationsToReduce)// check in console
            
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
    
            for _ in 1...3 {
                operationsToReduce.remove(at: index)
            }
            operationsToReduce.insert("\(result)", at: index)
                                                
            index = 0
            print("Elements après sous-total :")// check in console
            checkArrayInconsole(in: operationsToReduce)// check in console
            
        }//end of while
        print("Elements Total :")// check in console
        checkArrayInconsole(in: operationsToReduce)// check in console
        
        return operationsToReduce.first
    }
    
    
    // Function to check in console
    func checkArrayInconsole(in array: [String]) {
        print("operationToReduce contient :")
        for eachElement in array {
            print("\(eachElement)")
        }
    }

}

