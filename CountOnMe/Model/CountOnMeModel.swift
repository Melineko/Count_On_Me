//
//  CountOnMeModel.swift
//  CountOnMe
//
//  Created by Melissa Briere on 22/10/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

final class CountOnMeModel {
    
    var elements: [String] = []
    let result: Double = 0
    var displayResult = ""
    var alertText = ""
    var left = ""
    var right = ""
    
    
    

    //MARK: Error check computed variables
    var expressionIsCorrect: Bool {
        print(elements.last as Any)
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"{
            return true
        }else{
            alertText = AlertText.alertCases.notCorrectExpression.rawValue
            return false
        }
        
    }
    
    var expressionHaveEnoughElement: Bool {
        if elements.count >= 3{
            return true
        }else{
            alertText = AlertText.alertCases.haveEnoughtElements.rawValue
            return false
        }
    }
    
    var canAddOperator: Bool {
        if elements.last != "+" && elements.last != "-"  && elements.last != "x" && elements.last != "/"{
            return true
        }else{
            alertText = AlertText.alertCases.haveAlreadyOperator.rawValue
            return false
        }
    }
    
    // Add numbers to array
    func addElement(element: String){
            elements.append(element)
    }
    
    // Add operators to array
    func addOperator(element: String){
            elements.append(element)
        
    }
    
 
    
    // Add decimal
    func addDecimal(element: String){
        if isAutorizingDecimal(){
            elements.append(element)
        }
    }
    
    func isAutorizingDecimal()-> Bool{
        if elements.last == "."{
            return false
        }
        return true
    }
    
    
    // Clear elements
    func clearAllElements() {
        elements.removeAll()
    }
    
    // MAKE THE CALCUL
    func makeCalcul() -> String? {
        // Create local copy of operations
        var operationsToReduce = elements
        let left = Double(operationsToReduce[0])
        let operand = operationsToReduce[1]
        var result: Double = 0
        let right = Double(operationsToReduce[2])
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
           
            
            switch operand {
            case "+":
                result = left! + right!
            case "-":
                result = left! - right!
            case "x":
                result = left! * right!
            case "/":
                result = left! / right!
            default: fatalError("Operateur inconnu !")
            }
                operationsToReduce = Array(operationsToReduce.dropFirst(3))
                operationsToReduce.insert("\(result)", at: 0)
            
        
            
        }
        return operationsToReduce.first
    }
}
