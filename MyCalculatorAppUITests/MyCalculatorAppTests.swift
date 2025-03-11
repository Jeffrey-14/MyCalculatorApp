//
//  ContentView.swift
//  MyCalculatorApp
//
//  Created by Jeffrey on 11/7/24.
//  updated on 01/03/25
//

import XCTest

final class MyCalculatorAppTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true // Test across all UI configurations (e.g., light/dark mode, orientations)
    }
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }
    
    // Helper to get display text
    private func getDisplayText() -> String {
        return app.staticTexts.element(boundBy: 0).label
    }
    
    // Test all number buttons (0-9)
    @MainActor
    func testNumberButtons() throws {
        let numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for number in numbers {
            app.buttons["AC"].tap() // Reset before each number
            app.buttons[number].tap()
            XCTAssertEqual(getDisplayText(), number, "Display should show \(number) after tapping \(number)")
        }
    }
    
    // Test addition (e.g., 7 + 3 = 10)
    @MainActor
    func testAddition() throws {
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "10", "Display should show 10 after 7 + 3")
    }
    
    // Test subtraction (e.g., 9 - 4 = 5)
    @MainActor
    func testSubtraction() throws {
        app.buttons["9"].tap()
        app.buttons["-"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "5", "Display should show 5 after 9 - 4")
    }
    
    // Test multiplication (e.g., 5 × 2 = 10)
    @MainActor
    func testMultiplication() throws {
        app.buttons["5"].tap()
        app.buttons["×"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "10", "Display should show 10 after 5 × 2")
    }
    
    //Test negative answer (e.g., 4 - 9 = -5)
    @MainActor
    func testNegativeAnswer() throws {
        app.buttons["4"].tap()
        app.buttons["-"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "-5", "Display should show -5 after 4 - 9")
    }
    
    // Test division (e.g., 8 ÷ 2 = 4)
    @MainActor
    func testDivision() throws {
        app.buttons["8"].tap()
        app.buttons["÷"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "4", "Display should show 4 after 8 ÷ 2")
    }
    
    // Test division by zero (e.g., 8 ÷ 0 = Error)
    @MainActor
    func testDivisionByZero() throws {
        app.buttons["8"].tap()
        app.buttons["÷"].tap()
        app.buttons["0"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "Error", "Display should show 'Error' when dividing by zero")
    }
    
    // Test decimal input (e.g., 5.5)
    @MainActor
    func testDecimalInput() throws {
        app.buttons["5"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        XCTAssertEqual(getDisplayText(), "5.5", "Display should show 5.5 after entering decimal")
    }
    
    // Test decimal only once (e.g., 5..5 should still be 5.5)
    @MainActor
    func testSingleDecimalRestriction() throws {
        app.buttons["5"].tap()
        app.buttons["."].tap()
        app.buttons["."].tap() // Second decimal should be ignored
        app.buttons["5"].tap()
        XCTAssertEqual(getDisplayText(), "5.5", "Display should ignore second decimal and show 5.5")
    }
    
    // Test clear button (AC)
    @MainActor
    func testClearButton() throws {
        app.buttons["7"].tap()
        XCTAssertEqual(getDisplayText(), "7", "Display should show 7 before clearing")
        app.buttons["AC"].tap()
        XCTAssertEqual(getDisplayText(), "0", "Display should reset to 0 after AC")
    }
    
    // Test new calculation after result (e.g., 2 + 3 = 5, then 1 = 1)
    @MainActor
    func testNewCalculationAfterResult() throws {
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "5", "Display should show 5 after 2 + 3")
        app.buttons["1"].tap()
        XCTAssertEqual(getDisplayText(), "1", "Display should show 1 for new input after result")
    }
    
    // Test operator display (e.g., tapping + shows +)
    @MainActor
    func testOperatorDisplay() throws {
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        XCTAssertEqual(getDisplayText(), "+", "Display should show + after entering 5 and +")
    }
    
    // Test multi-digit input (e.g., 123)
    @MainActor
    func testMultiDigitInput() throws {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        XCTAssertEqual(getDisplayText(), "123", "Display should show 123 after entering 1, 2, 3")
    }
    
    // Test complex calculation (e.g., 12.5 × 2 = 25)
    @MainActor
    func testComplexCalculation() throws {
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["."].tap()
        app.buttons["5"].tap()
        app.buttons["×"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        XCTAssertEqual(getDisplayText(), "25", "Display should show 25 after 12.5 × 2")
    }
}
