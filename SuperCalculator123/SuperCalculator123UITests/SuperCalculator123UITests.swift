//
//  SuperCalculator123UITests.swift
//  SuperCalculator123UITests
//
//  Created by Davi Martignoni Barros on 11/07/25.
//

import XCTest

final class SuperCalculator123UITests: XCTestCase {

    var app: XCUIApplication! // Declare an instance of your UI application

    // This method is called before each test method in the class.
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false // Stop test execution on first failure

        // In UI tests it’s important to make sure the application is launched once before each test method.
        // Set up the UI testing framework and then launch the application.
        app = XCUIApplication()
        app.launch() // Launch your application before each test
    }

    // This method is called after each test method in the class.
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil // De-initialize to clean up
    }

    // MARK: - Basic UI Interaction Tests

    func testInitialDisplayShowsZero() {
        let display = app.staticTexts["0"] // Identify the display text "0"
        XCTAssertTrue(display.exists, "Initial display should show '0'")
    }

    func testPressingDigitUpdatesDisplay() {
        app.buttons["5"].tap() // Tap the "5" button
        let display = app.staticTexts["5"] // Identify the display text "5"
        XCTAssertTrue(display.exists, "Display should show '5' after tapping '5'")
    }

    func testSimpleAddition() {
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()

        let display = app.staticTexts["5"] // Assert the result "5"
        XCTAssertTrue(display.exists, "2 + 3 should result in '5'")
    }

    func testSubtractionWithClear() {
        app.buttons["1"].tap()
        app.buttons["0"].tap() // Tap "10"
        app.buttons["-"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()
        
        let resultDisplay = app.staticTexts["6"]
        XCTAssertTrue(resultDisplay.exists, "10 - 4 should result in '6'")
        
        app.buttons["AC"].tap() // Tap All Clear
        let clearedDisplay = app.staticTexts["0"]
        XCTAssertTrue(clearedDisplay.exists, "AC should reset display to '0'")
    }

    func testDivisionByZeroError() {
        app.buttons["1"].tap()
        app.buttons["0"].tap() // 10
        app.buttons["÷"].tap()
        app.buttons["0"].tap() // 0
        app.buttons["="].tap()

        let errorDisplay = app.staticTexts["Error"]
        XCTAssertTrue(errorDisplay.exists, "Division by zero should show 'Error'")
    }

    func testDecimalInput() {
        app.buttons["1"].tap()
        app.buttons["."].tap()
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["."].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()

        let resultDisplay = app.staticTexts["2,5"] // 1.2 + 1.3 = 2,5
        XCTAssertTrue(resultDisplay.exists, "1.2 + 1.3 should result in '2,5'")
    }

    func testChainedOperationsUI() {
        app.buttons["2"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["×"].tap() // Should calculate 2+3=5, then multiply by next number
        app.buttons["4"].tap()
        app.buttons["="].tap()
        
        // At this point, the calculation should be (2+3) * 4 = 20
        let resultDisplay = app.staticTexts["20"]
        XCTAssertTrue(resultDisplay.exists, "Chained operations (2+3)*4 should be 20")
    }
}
