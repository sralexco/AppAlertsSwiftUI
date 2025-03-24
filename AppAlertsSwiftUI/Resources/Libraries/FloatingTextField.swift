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

struct FloatingTextFieldAlter<Content: View>: View {
    var title: String
    @Binding var isError: Bool
    var requireValidation: Bool = true
    var content: () -> Content
    
    init(title: String, isError: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
          self.title = title
          self._isError = isError
          self.content = content
     }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.blue1)
            content()
            Rectangle().fill(isError ? Color.red : Color.gray2).opacity(0.6)
                .frame(height: 1)
                .padding(.top, 3)
        }
    }
}


struct FloatingTextFieldAlterTwo: View {
    let title: String
    @Binding var text :String
    @Binding var isError : Bool
    @Binding var isDisabled : Bool
    var requireValidation : Bool = true
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
                        .disabled(isDisabled)
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
                        .disabled(isDisabled)
                        .focused($isInputActive, equals: true)
                       /* .toolbar {
                            if isInputActive == true {
                                ToolbarItem(placement: .keyboard) {
                                    HStack{
                                        Button("Done"){
                                            isInputActive = false
                                        }
                                        Spacer()
                                    }
                                }
                            }
                        } */
                      
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
                    .disabled(isDisabled)
            }
            
            Rectangle().fill(isError ? Color.red : Color.gray2).opacity(0.6)
                .frame(height: 1)
                .padding(.top, 3)
        }
    }
}


/*
struct FloatingTextFieldAlterThree<Content: View>: View {
    var title: String
    @Binding var isError: Bool
    @Binding var isDisabled : Bool
    var requireValidation: Bool = true
    var content: () -> Content
    
    init(title: String, isError: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
          self.title = title
          self._isError = isError
          self.content = content
     }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.blue1)
            content()
                
            Rectangle().fill(isError ? Color.red : Color.gray2).opacity(0.6)
                .frame(height: 1)
                .padding(.top, 3)
        }
    }
}
*/
