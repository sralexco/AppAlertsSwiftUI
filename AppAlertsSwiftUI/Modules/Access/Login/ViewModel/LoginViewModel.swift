//
//  LoginModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: BaseViewModel {
    @Published var email: String = ""
    @Published var emailError: Bool = false
    @Published var pass: String = ""
    @Published var passError: Bool = false
    @Published var isLoading = false
    var service: LoginServiceProtocol
    
    var onLoginSuccess: (() -> Void)?
    
    init(service: LoginServiceProtocol = LoginService.shared) {
        self.service = service
        email = "gg@gmail.com"
        pass = "1234"
    }
    
    func validateInputs() -> Bool {
        emailError  = email.isEmpty ? true : false
        passError = pass.isEmpty ? true : false
        if !emailError && !passError {
            return true
        } else {
            showAlert(title: "Alert", message: "Complete all the fields")
            return false
        }
    }
    
    func getLogin() {
        guard validateInputs() else { return }
        isLoading = true
        Task {
        do {
            let obj = try await service.getLogin(email: email, pass: pass)
            await MainActor.run {
                if obj.status {
                    let token = obj.token?.token ?? ""
                    let idUser = obj.id ?? -1
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.set(idUser, forKey: "idUser")
                    UserDefaults.standard.set(true, forKey: "access")
                    
                    // Redirect To Home
                    onLoginSuccess?()
                } else {
                    showAlert(title: "Success", message: "Invalid username and password Please try again")
                }
                isLoading = false
            }
        } catch {
            await MainActor.run {
                showAlert(title: "Error", message: error.localizedDescription)
                isLoading = false
            }
        }
        }
    }
}
