//
//  CalculatorLogic.swift
//  iosCalculator
//
//  Created by Vaibhav Rajani on 10/6/23.
//

import SwiftUI

enum Operation {
    case add, subtract, multiply, divide, none
}

class CalculatorLogic: ObservableObject {
    @Published var value = "0"
    @Published var runningNumber = 0
    @Published var currentOperation: Operation = .none
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide:
            if button == .add {
                self.currentOperation = .add
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            } else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Int(self.value) ?? 0
            }
            
        case .equal:
            if self.currentOperation != .none {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .add: self.value = "\(runningValue + currentValue)"
                case .subtract: self.value = "\(runningValue - currentValue)"
                case .multiply: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
                self.currentOperation = .none
            }
            
        case .clear:
            self.value = "0"
            self.currentOperation = .none
            
        case .decimal, .percent:
            break
            
        case .negative:
            if self.value != "0" {
                if self.value.hasPrefix("-") {
                    self.value.remove(at: self.value.startIndex)
                } else {
                    self.value = "-" + self.value
                }
            }
            
        default:
            let number = button.rawValue
            if self.value == "0" || self.currentOperation != .none {
                self.value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }

