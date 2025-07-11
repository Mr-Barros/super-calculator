//
//  ContentView.swift
//  SuperCalculator123
//
//  Created by Davi Martignoni Barros on 11/07/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var calculator = CalculatorLogic()

    let buttonRows: [[ButtonType]] = [
        [.allClear, .plusMinus, .percent, .divide],
        [.digit(7), .digit(8), .digit(9), .multiply],
        [.digit(4), .digit(5), .digit(6), .subtract],
        [.digit(1), .digit(2), .digit(3), .add],
        [.digit(0), .decimal, .equals]
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 12) {
                Spacer()

                // Display
                HStack {
                    Spacer()
                    Text(calculator.displayValue)
                        .foregroundColor(.white)
                        .font(.system(size: 80, weight: .light))
                        .minimumScaleFactor(0.5) // Allow text to shrink
                        .lineLimit(1)
                        .padding(.trailing, 20)
                }

                // Buttons
                ForEach(buttonRows, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { buttonType in
                            CalculatorButton(buttonType: buttonType, calculator: calculator)
                        }
                    }
                }
                .padding(.bottom)
            }
        }
    }
}

// MARK: - CalculatorButton (Helper Struct for Buttons)

struct CalculatorButton: View {
    let buttonType: ButtonType
    @ObservedObject var calculator: CalculatorLogic

    var body: some View {
        Button(action: {
            // Handle button tap
            switch buttonType {
            case .digit(let digit):
                calculator.setDigit(String(digit))
            case .decimal:
                calculator.setDigit(".")
            case .add:
                calculator.setOperation(.add)
            case .subtract:
                calculator.setOperation(.subtract)
            case .multiply:
                calculator.setOperation(.multiply)
            case .divide:
                calculator.setOperation(.divide)
            case .equals:
                calculator.equals()
            case .allClear:
                calculator.clear()
            case .plusMinus:
                calculator.toggleSign()
            case .percent:
                calculator.setPercent()
            }
        }) {
            Text(buttonType.title)
                .font(.system(size: 32))
                .frame(
                    width: buttonWidth(buttonType: buttonType),
                    height: (UIScreen.main.bounds.width - 5 * 12) / 4
                )
                .background(buttonType.backgroundColor)
                .foregroundColor(buttonType.foregroundColor)
                .cornerRadius((UIScreen.main.bounds.width - 5 * 12) / 4) // Makes it circular
        }
    }

    private func buttonWidth(buttonType: ButtonType) -> CGFloat {
        if case .digit(0) = buttonType {
            // Special width for the zero button
            return ((UIScreen.main.bounds.width - 5 * 12) / 4) * 2 + 12
        }
        return (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}

// MARK: - ButtonType (Helper Enum for Button Configuration)

enum ButtonType: Hashable {
    case digit(Int)
    case decimal
    case add, subtract, multiply, divide, equals
    case allClear, plusMinus, percent

    var title: String {
        switch self {
        case .digit(let digit): return "\(digit)"
        case .decimal: return "."
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .equals: return "="
        case .allClear: return "AC"
        case .plusMinus: return "±"
        case .percent: return "%"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .allClear, .plusMinus, .percent: return Color(.lightGray)
        case .divide, .multiply, .subtract, .add, .equals: return .orange
        default: return Color(.darkGray)
        }
    }

    var foregroundColor: Color {
        switch self {
        case .allClear, .plusMinus, .percent: return .black
        default: return .white
        }
    }
}

#Preview {
    ContentView()
}
