//
//  FloatingTextField.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 8/03/25.
//

import SwiftUI

struct FloatingTextField: View {
    let title: String
    @Binding var text: String
    @Binding var isError: Bool
    var requireValidation: Bool = true
    var keyboardType = UIKeyboardType.default
    var isSecure = false
    var isNumber = false
    @FocusState var isInputActive: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.blue1)
            if isSecure == false {
                if isNumber == false {
                    TextField(title, text: $text)
                        .foregroundColor(.black2)
                        .font(.system(size: 16, weight: .regular))
                        .padding(.top, 2)
                        .keyboardType(keyboardType)
                        .onChange(of: text) {
                            if $0 != "" && requireValidation == true {
                                isError = false
                            } else {
                                isError = true
                            }
                        }
                } else {
                    TextField(title, text: $text)
                        .foregroundColor(.black2)
                        .font(.system(size: 16, weight: .regular))
                        .padding(.top, 2)
                        .keyboardType(keyboardType)
                        .onChange(of: text) {
                            if $0 != "" && requireValidation == true {
                                isError = false
                            } else {
                                isError = true
                            }
                        }
                        .focused($isInputActive, equals: true)
                        .toolbar {
                                if isInputActive {  // Condition applied inside .toolbar
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            isInputActive = false
                                        }
                                    }
                                }
                            }
                }
            } else {
                SecureField(title, text: $text)
                    .foregroundColor(.black2)
                    .font(.system(size: 16, weight: .regular))
                    .padding(.top, 2)
                    .keyboardType(keyboardType)
                    .onChange(of: text) {
                        if $0 != "" && requireValidation == true {
                            isError = false
                        } else {
                            isError = true
                        }
                    }
            }
            Rectangle().fill(isError ? Color.red : Color.gray2).opacity(0.6)
                .frame(height: 1)
                .padding(.top, 3)
        }
        .frame(maxWidth: .infinity)
    }
}
