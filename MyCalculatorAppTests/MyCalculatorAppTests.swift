//
//  MyCalculatorAppTests.swift
//  MyCalculatorAppTests
//
//  Created by Nana Yaw on 11/7/24.
//

import Testing
@testable import MyCalculatorApp

struct MyCalculatorAppTests {
    
    @Test func testAddition() throws {
        let calculator = ContentView()
        calculator.buttonTap("5")
        calculator.buttonTap("+")
        calculator.buttonTap("3")
        calculator.buttonTap("=")
        
        #expect(calculator.displayText == "8")
    }
    
    @Test func testClearButton() throws {
        let calculator = ContentView()
        calculator.buttonTap("7")
        calculator.buttonTap("+")
        calculator.buttonTap("2")
        
        calculator.clearButton()
        
        #expect(calculator.displayText == "0")
        #expect(calculator.currentInput.isEmpty)
        #expect(calculator.storedValue == nil)
        #expect(calculator.currentOperator == nil)
    }
    
    @Test func testDivisionByZero() throws {
        let calculator = ContentView()
        calculator.buttonTap("6")
        calculator.buttonTap("÷")
        calculator.buttonTap("0")
        calculator.buttonTap("=")
        
        #expect(calculator.displayText == "Error")
        #expect(calculator.currentInput.isEmpty)
        #expect(calculator.storedValue == nil)
    }
    
    @Test func testDecimalInput() throws {
        let calculator = ContentView()
        calculator.buttonTap("4")
        calculator.buttonTap(".")
        calculator.buttonTap("2")
        
        #expect(calculator.displayText == "4.2")
    }
}
