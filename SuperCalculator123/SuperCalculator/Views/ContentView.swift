//
//  ContentView.swift
//  SuperCalculator
//
//  Created by Davi Martignoni Barros on 10/07/25.
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

#Preview {
    ContentView()
}
