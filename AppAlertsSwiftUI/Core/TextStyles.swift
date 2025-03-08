//
//  TextStyles.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

enum TextType {
    case primary
}

struct CustomTextStyle: ViewModifier {
    let type: TextType

    func body(content: Content) -> some View {
        switch type {
        case .primary:
            content
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
        }
    }
}

extension Text {
    func customStyle(_ type: TextType) -> some View {
        self.modifier(CustomTextStyle(type: type))
    }
}
