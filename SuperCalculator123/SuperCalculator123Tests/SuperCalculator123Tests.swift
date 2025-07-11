//
//  SuperCalculator123Tests.swift
//  SuperCalculator123Tests
//
//  Created by Davi Martignoni Barros on 11/07/25.
//

import XCTest
@testable import SuperCalculator123 // Import your app module to access CalculatorLogic

final class SuperCalculator123Tests: XCTestCase {

    var calculator: CalculatorLogic! // Declare an instance of your logic class

    // This method is called before each test method in the class.
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        calculator = CalculatorLogic() // Initialize a fresh calculator for each test
    }

    // This method is called after each test method in the class.
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        calculator = nil // De-initialize to clean up
    }

    // MARK: - Digit and Clear Tests

    func testInitialDisplayValue() {
        XCTAssertEqual(calculator.displayValue, "0", "Initial display value should be '0'")
    }

    func testSetSingleDigit() {
        calculator.setDigit("5")
        XCTAssertEqual(calculator.displayValue, "5", "Display should show single digit '5'")
    }

    func testSetMultipleDigits() {
        calculator.setDigit("1")
        calculator.setDigit("2")
        calculator.setDigit("3")
        XCTAssertEqual(calculator.displayValue, "123", "Display should concatenate multiple digits")
    }

    func testSetDecimal() {
        calculator.setDigit("1")
        calculator.setDigit(".")
        calculator.setDigit("5")
        XCTAssertEqual(calculator.displayValue, "1.5", "Display should handle decimal point")
    }

    func testClearFunctionality() {
        calculator.setDigit("1")
        calculator.setOperation(.add)
        calculator.setDigit("2")
        calculator.clear()
        XCTAssertEqual(calculator.displayValue, "0", "Clear should reset display to '0'")
    }

    // MARK: - Arithmetic Operation Tests

    func testAddition() {
        calculator.setDigit("5")
        calculator.setOperation(.add)
        calculator.setDigit("3")
        calculator.equals()
        XCTAssertEqual(calculator.displayValue, "8", "5 + 3 should be 8")
    }

    func testSubtraction() {
        calculator.setDigit("10")
        calculator.setOperation(.subtract)
        calculator.setDigit("4")
        calculator.equals()
        XCTAssertEqual(calculator.displayValue, "6", "10 - 4 should be 6")
    }

    func testMultiplication() {
        calculator.setDigit("6")
        calculator.setOperation(.multiply)
        calculator.setDigit("7")
        calculator.equals()
        XCTAssertEqual(calculator.displayValue, "42", "6 * 7 should be 42")
    }

    func testDivision() {
        calculator.setDigit("20")
        calculator.setOperation(.divide)
        calculator.setDigit("5")
        calculator.equals()
        XCTAssertEqual(calculator.displayValue, "4", "20 / 5 should be 4")
    }

    func testDivisionByZero() {
        calculator.setDigit("10")
        calculator.setOperation(.divide)
        calculator.setDigit("0")
        calculator.equals()
        XCTAssertEqual(calculator.displayValue, "Error", "Division by zero should result in 'Error'")
    }

    // MARK: - Chained Operations & Edge Cases

    func testChainedAddition() {
        calculator.setDigit("2")
        calculator.setOperation(.add)
        calculator.setDigit("3")
        calculator.setOperation(.add) // This should perform 2+3=5 first
        calculator.setDigit("4")
        calculator.equals()
        XCTAssertEqual(calculator.displayValue, "9", "2 + 3 + 4 should be 9")
    }

    func testToggleSign() {
        calculator.setDigit("5")
        calculator.toggleSign()
        XCTAssertEqual(calculator.displayValue, "-5", "Toggling sign of 5 should be -5")
        calculator.toggleSign()
        XCTAssertEqual(calculator.displayValue, "5", "Toggling sign of -5 should be 5")
    }

    func testPercent() {
        calculator.setDigit("50")
        calculator.setPercent()
        XCTAssertEqual(calculator.displayValue, "0.5", "50% should be 0.5")
    }

    func testDecimalPointOnce() {
        calculator.setDigit("1")
        calculator.setDigit(".")
        calculator.setDigit(".") // Should ignore second decimal
        calculator.setDigit("2")
        XCTAssertEqual(calculator.displayValue, "1.2", "Only one decimal point should be allowed")
    }
}
