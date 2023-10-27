//
//  ContentView.swift
//  iosCalculator
//
//  Created by Vaibhav Rajani on 10/6/23.
//

import SwiftUI
import Combine

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {
    @State private var value = "0"
    @State private var runningNumber : Double = 0
    @State private var currentOperation : Operation = .none
    @State private var isDecimal = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    private let valueSubject = PassthroughSubject<String, Never>()
    var currentButton: CalcButton?
    
    let portraitButtons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    let landscapeButtons: [[CalcButton]] = [
        [.openBracket, .closingBracket, .mc, .mPlus, .mMinus, .mr, .clear, .negative, .percent, .divide],
        [.second, .xsq, .xcu, .xy, .ex, .tenx, .seven, .eight, .nine, .multiply],
        [.onex, .root2, .root3, .rootyx, .ln, .log10, .four, .five, .six, .subtract],
        [.xfact, .sin, .cos, .tan, .e, .EE, .one, .two, .three, .add],
        [.Rad, .sinh, .cosh, .tanh, .pi, .rand, .zero, .decimal, .equal],
    ]
    
    var buttonWidth: CGFloat {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            return (UIScreen.main.bounds.width - (5 * 12)) / 4
        } 
        else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return (UIScreen.main.bounds.width - (9 * 60)) / 2
        }
        else {
            return (UIScreen.main.bounds.width - (5 * 12)) / 13
        }
    }
    
    var buttonHeight: CGFloat {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular {
            return (UIScreen.main.bounds.width - (6 * 12)) / 5
        }
        else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            return (UIScreen.main.bounds.width - (9 * 60)) / 5
        }
        else {
            return (UIScreen.main.bounds.width - (8 * 60)) / 10
        }
    }
    
    var body: some View {
        if (horizontalSizeClass == .compact && verticalSizeClass == .regular) {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: horizontalSizeClass == .regular ? 50 : 100))
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    ForEach(0..<portraitButtons.count, id: \.self) { rowIndex in
                        HStack(spacing: 12) {
                            ForEach(0..<portraitButtons[rowIndex].count, id: \.self) { columnIndex in
                                let button = portraitButtons[rowIndex][columnIndex]
                                Button(action: {
                                    self.didTap(button: button)
                                }, label: {
                                    Text(button.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: button == .zero ? self.buttonWidth * 2 : self.buttonWidth,
                                            height: self.buttonHeight
                                        )
                                        .background(button.buttonColor)
                                        .foregroundColor(.black)
                                })
                                .onReceive(valueSubject) { newValue in
                                    self.value = newValue
                                }
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
            }
            
        }
        
        else if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: 150))
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    ForEach(0..<portraitButtons.count, id: \.self) { rowIndex in
                        HStack(spacing: 12) {
                            ForEach(0..<portraitButtons[rowIndex].count, id: \.self) { columnIndex in
                                let button = portraitButtons[rowIndex][columnIndex]
                                Button(action: {
                                    self.didTap(button: button)
                                }, label: {
                                    Text(button.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: button == .zero ? self.buttonWidth * 2 : self.buttonWidth,
                                            height: self.buttonHeight
                                        )
                                        .background(button.buttonColor)
                                        .foregroundColor(.black)
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
            }
        }
        else  {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    ForEach(0..<landscapeButtons.count, id: \.self) { rowIndex in
                        HStack(spacing: 12) {
                            ForEach(0..<landscapeButtons[rowIndex].count, id: \.self) { columnIndex in
                                let button = landscapeButtons[rowIndex][columnIndex]
                                Button(action: {
                                    self.didTap(button: button)
                                }, label: {
                                    Text(button.rawValue)
                                        .font(.system(size: 32))
                                        .frame(
                                            width: button == .zero ? self.buttonWidth * 2 : self.buttonWidth,
                                            height: self.buttonHeight
                                        )
                                        .background(button.buttonColor)
                                        .foregroundColor(.black)
                                })
                            }
                        }
                        .padding(.bottom, 3)
                    }
                }
            }
        }
    }
    
    func didTap(button: CalcButton) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            if button != .equal {
                self.runningNumber = Double(self.value) ?? 0
                self.isDecimal = self.value.contains(".")
            }
            if button == .add {
                self.currentOperation = .add
                self.value = "+"
            } else if button == .subtract {
                self.currentOperation = .subtract
                self.value = "-"
            } else if button == .multiply {
                self.currentOperation = .multiply
                self.value = "x"
            } else if button == .divide {
                self.currentOperation = .divide
                self.value = "/"
            } else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                switch self.currentOperation {
                case .add:
                    self.value = formatResult(runningNumber + currentValue)
                case .subtract:
                    self.value = formatResult(runningNumber - currentValue)
                case .multiply:
                    self.value = formatResult(runningNumber * currentValue)
                case .divide:
                    if currentValue != 0.0 {
                        self.value = formatResult(runningNumber / currentValue)
                    } else {
                        self.value = "Error"
                    }
                case .none:
                    break
                }
            }
        case .clear:
            self.value = "0"
            self.isDecimal = false // Clear the decimal flag
        case .decimal:
            if !isDecimal {
                self.value += "."
                self.isDecimal = true // Set the decimal flag
            }
        case .percent:
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
            if self.value == "0" || self.value == "+" || self.value == "-" || self.value == "x" || self.value == "/" {
                self.value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    private func formatResult(_ result: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: result)) ?? "0"
    }
}



struct ContentView_Previews: PreviewProvider{
    static var previews: some View {
        ContentView()
    }
}
