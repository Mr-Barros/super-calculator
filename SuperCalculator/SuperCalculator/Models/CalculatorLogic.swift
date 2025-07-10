//
//  CalculatorLogic.swift
//  SuperCalculator
//
//  Created by Davi Martignoni Barros on 10/07/25.
//

import Foundation

class CalculatorLogic: ObservableObject {
    @Published var displayValue: String = "0"

    private var currentNumber: Double?
    private var previousNumber: Double?
    private var currentOperation: Operation?
    private var awaitingNewNumber: Bool = true // True after an operation or equals, indicates next digit should start a new number

    enum Operation {
        case add, subtract, multiply, divide, equals, none

        var symbol: String {
            switch self {
            case .add: return "+"
            case .subtract: return "-"
            case .multiply: return "×" // Or "*"
            case .divide: return "÷" // Or "/"
            case .equals: return "="
            case .none: return ""
            }
        }
    }

    func setDigit(_ digit: String) {
        if awaitingNewNumber {
            displayValue = digit
            awaitingNewNumber = false
        } else {
            if displayValue == "0" && digit == "0" { return } // Prevent multiple leading zeros
            if digit == "." && displayValue.contains(".") { return } // Prevent multiple decimal points
            displayValue += digit
        }
        currentNumber = Double(displayValue)
    }

    func setOperation(_ operation: Operation) {
        if let currentNum = currentNumber {
            if previousNumber == nil || currentOperation == .equals || currentOperation == .none {
                previousNumber = currentNum
            } else {
                // Perform pending calculation before setting new operation
                performCalculation()
                previousNumber = Double(displayValue) // Update previous number with result
            }
        }

        currentOperation = operation
        awaitingNewNumber = true
    }

    func equals() {
        performCalculation()
        currentOperation = .equals // Mark as equals operation completed
        awaitingNewNumber = true
    }

    func clear() {
        displayValue = "0"
        currentNumber = nil
        previousNumber = nil
        currentOperation = .none
        awaitingNewNumber = true
    }

    func toggleSign() {
        if let currentNum = currentNumber {
            displayValue = String(format: "%g", -currentNum)
            currentNumber = Double(displayValue)
        }
    }

    func setPercent() {
        if let currentNum = currentNumber {
            displayValue = String(format: "%g", currentNum / 100)
            currentNumber = Double(displayValue)
        }
    }

    private func performCalculation() {
        guard let prevNum = previousNumber, let currentNum = currentNumber, let operation = currentOperation else {
            return
        }

        var result: Double?

        switch operation {
        case .add:
            result = prevNum + currentNum
        case .subtract:
            result = prevNum - currentNum
        case .multiply:
            result = prevNum * currentNum
        case .divide:
            if currentNum != 0 {
                result = prevNum / currentNum
            } else {
                displayValue = "Error"
                previousNumber = nil // Clear state on error
                currentNumber = nil
                currentOperation = .none
                return
            }
        case .equals, .none:
            return // Should not happen or handled by previous logic
        }

        if let finalResult = result {
            // Format result to remove trailing .0 if it's an integer
            let formatter = NumberFormatter()
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 9 // Adjust as needed
            formatter.numberStyle = .decimal
            displayValue = formatter.string(from: NSNumber(value: finalResult)) ?? "\(finalResult)"

            previousNumber = finalResult
            currentNumber = finalResult // For potential chained operations after equals
        }
    }
}
