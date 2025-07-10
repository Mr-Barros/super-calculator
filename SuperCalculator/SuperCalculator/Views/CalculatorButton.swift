//
//  CalculatorButton.swift
//  SuperCalculator
//
//  Created by Davi Martignoni Barros on 10/07/25.
//

import SwiftUI

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

#Preview {
    CalculatorButton(buttonType: .add, calculator: CalculatorLogic())
}
