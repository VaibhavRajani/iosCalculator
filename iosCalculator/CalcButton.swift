//
//  CalcButton.swift
//  iosCalculator
//
//  Created by Vaibhav Rajani on 10/6/23.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    case openBracket = "("
    case closingBracket = ")"
    case mc = "mc"
    case mPlus = "m+"
    case mMinus = "m-"
    case mr = "mr"
    case second = "2ⁿᵈ"
    case xsq = "x²"
    case xcu = "x³"
    case xy = "xʸ"
    case ex = "eˣ"
    case tenx = "10ˣ"
    case onex = "1/x"
    case root2 = "√x"
    case root3 = "∛x"
    case rootyx = "y√x"
    case ln = "ln"
    case log10 = "log₁₀"
    case xfact = "x!"
    case sin = "sin"
    case cos = "cos"
    case tan = "tan"
    case e = "e"
    case EE = "EE"
    case Rad = "Rad"
    case sinh = "sinh"
    case cosh = "cosh"
    case tanh = "tanh"
    case pi = "Π"
    case rand = "Rand"
    
    
    var buttonColor: Color {
        switch self{
        case.add, .subtract, .multiply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 200/255.0, green: 200/255.0, blue: 200/255.0, alpha: 1))
        }
    }
}
