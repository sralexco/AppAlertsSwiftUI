//
//  LoginModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var emailError: Bool = false
    @Published var pass: String = ""
    @Published var passError: Bool = false
}
