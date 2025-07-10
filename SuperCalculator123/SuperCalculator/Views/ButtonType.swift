//
//  ButtonType.swift
//  SuperCalculator
//
//  Created by Davi Martignoni Barros on 10/07/25.
//

import SwiftUI

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
