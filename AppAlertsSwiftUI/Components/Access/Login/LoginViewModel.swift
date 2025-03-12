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
    
    private var cancellableSet: Set<AnyCancellable> = []
    var service: LoginServiceProtocol
    
    init(service: LoginServiceProtocol = LoginService.shared) {
        self.service = service
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
        service.getLogin(email: email, pass: pass)
        .sink { (dataResponse) in
            self.isLoading = false
            if let error = dataResponse.error {
                return self.showAlert(title: "Error", message: error.localizedDescription) }
            self.getLoginHandle(obj: dataResponse.value!)
        }.store(in: &cancellableSet)
    }
    
    func getLoginHandle(obj: LoginModel) {
        if obj.status {
            print("InViewModel")
            print("email", obj.email!)
            print("token", obj.token?.token)
        } else {
            showAlert(title: "Success", message: "Invalid username and password Please try again")
        }
    }
}
