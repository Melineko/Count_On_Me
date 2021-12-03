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

    func testGivenAdditionIsMaking_WhenTapEqual_ThenResultIsSum() {
        model.tappedNumber(number: "2")
        model.tappedOperator(buttonTapped: 2)// tag 2 for "+"
        model.tappedNumber(number: "3")
        if let unwrapResult = model.makeCalcul(){
            result = unwrapResult
        }
        XCTAssert(result == "5")
    }
    
    func testGivenSoustractionIsMaking_WhenTapEqual_ThenResultIsDifference() {
        model.tappedNumber(number: "5")
        model.tappedOperator(buttonTapped: 1)// tag 1 for "-"
        model.tappedNumber(number: "3")
        if let unwrapResult = model.makeCalcul(){
            result = unwrapResult
        }
        XCTAssert(result == "2")
    }
    
    func testGivenMultiplicationIsMaking_WhenTapEqual_ThenResultIsProduct() {
        model.tappedNumber(number: "3")
        model.tappedOperator(buttonTapped: 3)// tag 3 for "x"
        model.tappedNumber(number: "5")
        if let unwrapResult = model.makeCalcul(){
            result = unwrapResult
        }
        XCTAssert(result == "15")
    }
    
    

}
