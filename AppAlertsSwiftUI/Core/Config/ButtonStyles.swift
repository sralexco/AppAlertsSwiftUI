//
//  StyleButtons.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

enum ButtonType {
    case primary
}

struct CustomButtonStyle: ButtonStyle {
    let type: ButtonType

    func makeBody(configuration: Configuration) -> some View {
        switch type {
        case .primary:
            return configuration.label
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color.blue1)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .medium))
                .cornerRadius(12)
                .padding(.horizontal, 20)
                .opacity(configuration.isPressed ? 0.7 : 1.0)
        }
    }
}

extension Button {
    func customStyle(_ type: ButtonType) -> some View {
        self.buttonStyle(CustomButtonStyle(type: type))
    }
}
