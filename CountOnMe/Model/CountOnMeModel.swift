//
//  CountOnMeModel.swift
//  CountOnMe
//
//  Created by Melissa Briere on 22/10/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

final class CountOnMeModel {
    
    let result: Double = 0
    var calculText: String = ""
    var resultText: String = ""
    var alertText = "Non valide"
    
    
    // Transforms calculText into an array of Strings
    var elements: [String] {
        return calculText.split(separator: " ").map { "\($0)" }
    }
    
    // MARK: - Error check computed variables
    // Is already a result
    var expressionHaveResult: Bool {
        return resultText.firstIndex(of: "=") != nil
    }
    
    // Check the number of decimal
    func numberOfDecimal() -> Int {
        var decimalCount = 0
        if let lastElement: String = elements.last {
            if lastElement.contains(".") {
                decimalCount += 1
            }
        }
        return decimalCount
    }
    
    // Check if last character of last element is decimal
    var isLastCharacterDecimal: Bool {
        if let lastElement = elements.last {
            if lastElement.suffix(1) == "." {
                return true
            }
        }
        return false
    }
    
    // Check if is already there a decimal
    var isDecimal: Bool {
        if isLastCharacterDecimal || numberOfDecimal() > 0 {
            return true
        }
        return false
    }
    
    var expressionIsCorrect: Bool {
        print(elements.last as Any)
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && !isLastCharacterDecimal {
            return true
        }
        alertText = AlertText.AlertCases.notCorrectExpression.rawValue
        return false
    }
    
    var expressionHaveEnoughElement: Bool {
        if elements.count >= 3 {
            return true
        }
        alertText = AlertText.AlertCases.haveEnoughtElements.rawValue
        return false
    }
    
    var canAddOperator: Bool {
        if elements.last != "+" && elements.last != "-"  && elements.last != "x" && elements.last != "/" {
            return true
        }
        alertText = AlertText.AlertCases.haveAlreadyOperator.rawValue
        return false
    }
    
    var isDivisionByZero: Bool {
        if !calculText.contains("/ 0") {
            return false
        }
        return true
    }
    
    // MARK: - Buttons fonctionnalities
    
    // Numbers
    func tappedNumber(number: String) {
        if expressionHaveResult || resultText == "ERREUR" {
            tappedAllClear()
        }
        calculText.append(number)
    }
    
    // Operators
    func tappedOperator(buttonTapped: Int) {
        // Continue operation with precedent result
        if expressionHaveResult {
            resultText = ""
            if let displayNewResult = makeCalcul() {
                calculText = "\(displayNewResult)"
            }
        } 
        switch buttonTapped {
        
        case 1:
            removeLastSpace()
            calculText.append(" - ")
        case 2:
            removeLastSpace()
            calculText.append(" + ")
        case 3:
            removeLastSpace()
            calculText.append(" x ")
        case 4:
            removeLastSpace()
            calculText.append(" / ")
        default:
            break
        }
    }
    
    // Decimale
    func tappedDecimale() {
        // Take result to complete with decimal
        if resultText == "ERREUR" {
            tappedAllClear()
        } else if expressionHaveResult {
            resultText = ""
            if let displayNewResult = makeCalcul() {
                calculText = "\(displayNewResult)"
            }
        }
        if !isDecimal{
            calculText.append(".")
            
            if let elements = elements.last, elements.count == 1 {
                calculText.removeLast()
                calculText.append("0.")
            }
        }
        return
    }
    
    // Erase
    func tappedErase() {
        removeLastSpace()
        let newEntrie = String(calculText.dropLast())
        calculText = ("\(newEntrie)")
    }
    
    // If there is a space remove last space
    func removeLastSpace() {
        if calculText.last == " " {
            calculText.removeLast()
        }
    }
    // All clear
    func tappedAllClear() {
        calculText = ""
        resultText = ""
    }
 
    // MARK: - Logic
    
    // MAKE THE CALCUL
    func makeCalcul() -> String? {
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            var index = self.priorisation(operationsToReduce: operationsToReduce)
            let result: Double = self.calcul(operationsToReduce: operationsToReduce, index: index)
            
            for _ in 1...3 {
                operationsToReduce.remove(at: index)
            }
            let roundedResult = round(result * 100) / 100.0
            operationsToReduce.insert("\(roundedResult.stringWithoutZeroFraction)", at: index)
            
            index = 0
            
        }//end of while
        
        return operationsToReduce.first
    }
    
    private func priorisation(operationsToReduce: [String]) -> Int {
        for indice in 0..<operationsToReduce.count {
            if operationsToReduce[indice].contains("x") || operationsToReduce[indice].contains("/") {
                return indice - 1
            }
        }
        return 0
    }
    
    private func calcul(operationsToReduce: [String], index: Int) -> Double {
        guard let left = Double(operationsToReduce[index]), let right = Double(operationsToReduce[index+2]) else { return 0.0}
        let operand = operationsToReduce[index+1]
        
        switch operand {
        case "+":
            return left + right
        case "-":
            return left - right
        case "x":
            return left * right
        case "/":
            return left / right
        default:
            break
        }
        return 0.0
    }
    
    // Display result
    func printResult() {
        guard let resultPrint = makeCalcul() else { return }
        if !isDivisionByZero {
        resultText = "= \(resultPrint)"
        } else {
        resultText = "ERREUR"
        }
    }

}
