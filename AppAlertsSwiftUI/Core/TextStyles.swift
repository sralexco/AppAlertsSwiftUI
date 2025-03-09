//
//  TextStyles.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

enum TextType {
    case primary
    case textfield
    case placeholder
}

struct CustomTextStyle: ViewModifier {
    let type: TextType

    func body(content: Content) -> some View {
        switch type {
        case .primary:
            content
            .font(.system(size: 40, weight: .bold))
            .foregroundColor(.white)
        case .textfield:
            content
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.black1)
        case .placeholder:
            content
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.gray)
            .opacity(0.5)
        }
    }
}

extension Text {
    func customStyle(_ type: TextType) -> some View {
        self.modifier(CustomTextStyle(type: type))
    }
}
