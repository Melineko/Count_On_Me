//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {
    var model : CountOnMeModel!
    var result = "0"
    
    override func setUp() {
        super.setUp()
        model = CountOnMeModel()
    }
    
    // Addition
    func testGivenAdditionIsMaking_WhenTapEqual_ThenResultIsSum() {
        makeCalculWith(number1: "2", operatorUsed: 2, number2: "3", resultExpected: "5")
        // tag 2 for "+"
    }
    // Soustraction
    func testGivenSoustractionIsMaking_WhenTapEqual_ThenResultIsDifference() {
        makeCalculWith(number1: "5", operatorUsed: 1, number2: "3", resultExpected: "2")
        // tag 1 for "-"
    }
    // Multiplication
    func testGivenMultiplicationIsMaking_WhenTapEqual_ThenResultIsProduct() {
        makeCalculWith(number1: "3", operatorUsed: 3, number2: "5", resultExpected: "15")
        // tag 3 for "x"
    }
    // Division
    func testGivenDivisionIsMaking_WhenTapEqual_ThenResultIsQuotient() {
        makeCalculWith(number1: "6", operatorUsed: 4, number2: "3", resultExpected: "2")
        // tag 4 for "/"
    }
    // Prioristaion
    func testGivenMultiOperatorCalcul_WhenTapEqual_ThenPriorisationWasMade() {
        model.tappedAllClear()
        model.calculText = "2 x 3 + 5 - 4 / 2"
        if let unwrapResult = model.makeCalcul(){
            result = unwrapResult
        }
        XCTAssert(result == "9")
    }
    // Equal
    func testGivenCalcul_WhenTapEqual_ThenResultAppearsInResultText() {
        makeCalculWith(number1: "5", operatorUsed: 3, number2: "6", resultExpected: "30")
        model.printResult()
        
        XCTAssert(model.resultText == "= 30")
    }
    // Decimale
    func testGivenNumberWasTapped_WhenTapDecimaleAndNumber_ThenDecimalNumberAppear() {
        model.tappedNumber(number: "2")
        model.tappedDecimale()
        model.tappedNumber(number: "8")
        
        XCTAssert(model.isDecimal == true)
        XCTAssert(model.calculText == "2.8")
    }
    // Decimale tapped more than one time
    func testGivenNumberWasTapped_WhenTapDecimaleTwice_ThenAdditionalDecimaleCantBePut() {
        model.tappedNumber(number: "2")
        model.tappedDecimale()
        XCTAssert(model.isLastCharacterDecimal == true)
        model.tappedDecimale()
        model.tappedNumber(number: "8")
        
        XCTAssert(model.calculText == "2.8")
    }
    // Decimal tapped but already decimal in number
    func testGivenDecimalNumberWasTapped_WhenTapDecimal_ThenAdditionalDecimaleCantBePut() {
        model.tappedNumber(number: "2")
        model.tappedDecimale()
        model.tappedNumber(number: "8")
        model.tappedDecimale()
        
        XCTAssert(model.numberOfDecimal() == 1)
        XCTAssert(model.calculText == "2.8")
    }
    // 0. replace .
    func testGivenAllIsClear_WhenTapDecimale_ThenZeroIsPrintingbefore() {
        model.tappedAllClear()
        model.tappedDecimale()
        
        XCTAssert(model.calculText == "0.")
    }
    // Decimale tapped before an operator
    func testGivenNumberandDecimalTapped_WhenTapOperator_ThenAlertMessageAppears() {
        model.tappedNumber(number: "5")
        model.tappedDecimale()
        model.tappedOperator(buttonTapped: 2)
        
        XCTAssert(model.expressionIsCorrect == false)
        XCTAssert(model.alertText == AlertText.AlertCases.notCorrectExpression.rawValue)
    }
    // Operator tapped twice
    func testGivenOperatorTapped_WhenTapOperator_ThenAlertMessageAppears() {
        model.tappedNumber(number: "5")
        model.tappedOperator(buttonTapped: 2)
        model.tappedOperator(buttonTapped: 2)
        
        XCTAssert(model.canAddOperator == false)
        XCTAssert(model.alertText == AlertText.AlertCases.haveAlreadyOperator.rawValue)
    }
    // Erase
    func testGivenEntrie_WhenTapErase_ThenLastEntrieIsRemoved() {
        model.tappedNumber(number: "12")
        model.tappedDecimale()
        model.tappedNumber(number: "5")
        model.tappedErase()
        
        XCTAssert(model.calculText == "12.")
    }
    // All Clear
    func testGivenEntrie_WhenTapAllClear_ThenRemoveAllTheEntries() {
        model.tappedNumber(number: "10")
        model.tappedOperator(buttonTapped: 3)
        model.tappedNumber(number: "2")
        model.printResult()
        model.tappedAllClear()
        
        XCTAssert(model.calculText == "" && model.resultText == "")
        
    }
    
    
    
    
    
    
    
    // calcul fonction
    func makeCalculWith(number1: String, operatorUsed: Int, number2: String, resultExpected: String) {
        model.tappedNumber(number: number1)
        model.tappedOperator(buttonTapped: operatorUsed)// tag 4 for "/"
        model.tappedNumber(number: number2)
        if let unwrapResult = model.makeCalcul(){
            result = unwrapResult
        }
        XCTAssert(result == resultExpected)
    }
}
