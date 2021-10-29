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
    var displayResult = ""
    var alertText = ""
    let operators = ["+","-","x","/","="]
    
    enum alertCases: String{
        case notCorrectExpression = "Entrez une expression correcte !"
        case notEnoughtElements = "Démarrez un nouveau calcul !"
        case haveAlreadyOperator = "Un operateur est déjà mis !"
        case divisionForZero = "Erreur"
    }

    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "÷"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"  && elements.last != "x" && elements.last != "÷"
    }
    
    // Add numbers to array
    func addElement(element: String){
        if elements.isEmpty{
            elements.append(element)
        }
    }
    
    // Add operators to array
    func addOperator(element: String){
            elements.append(element)
        
    }
    // is there already an operator
    func operatorChecking() -> Bool {
        if !canAddOperator {
            alertText = alertCases.haveAlreadyOperator.rawValue
            return false
        }
        return true
    }
    
    // Add decimal
    func addDecimal(){
        
    }
    
    func clearAllElements() {
        elements.removeAll()
    }
    
    // MAKE TE CALCUL
    
}
