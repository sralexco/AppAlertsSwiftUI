//
//  RegisterViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 8/03/25.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var nameError: Bool = false
    @Published var email: String = ""
    @Published var emailError: Bool = false
    @Published var pass: String = ""
    @Published var passError: Bool = false
    @Published var phone: String = ""
    @Published var phoneError: Bool = false
}
