//
//  ButtonView.swift
//  iosCalculator
//
//  Created by Vaibhav Rajani on 10/6/23.
//

import SwiftUI

struct ButtonView: View {
    let button: CalcButton
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(button.rawValue)
                .font(.system(size: 32))
                .frame(
                    width: button == .zero ? self.buttonWidth * 2 : self.buttonWidth,
                    height: self.buttonHeight
                )
                .background(button.buttonColor)
                .foregroundColor(.black)
        }
    }
}
