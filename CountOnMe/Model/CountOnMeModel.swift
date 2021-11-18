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
    var isDecimal: Bool {
        if let lastElement = elements.last {
            if lastElement.suffix(1) != "." || lastElement.contains = "."{
            print("\(lastElement)")
            print("isDecimal : false")// check in console
            return false
        }
        print("isDecimal : true")// check in console
        }
        return true
    }

    //MARK: Error check computed variables
    var expressionIsCorrect: Bool {
        print(elements.last as Any)
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && !isDecimal{
            print("expressionIsCorrect : true")// check in console
            return true
        }else{
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
        }else if expressionHaveResult{
            print("canAddOperator : true car il ya un resultat")// check in console
            return true
        }else{
            print("canAddOperator : false")// check in console
            alertText = AlertText.AlertCases.haveAlreadyOperator.rawValue
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
    
            for _ in 1...3{
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
    
    
    // Replace the first index with result
    func startingWithResult(){
        
    }
    
    func checkArrayInconsole(in array: [String]){
        for eachElement in array {
            print("operationToReduce contient :")
            print("\(eachElement)")
        }
    }

}

