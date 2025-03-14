//
//  LoginService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 12/03/25.
//

import Foundation
import Combine
import Alamofire

protocol LoginServiceProtocol {
    func getLogin(email: String, pass: String) async throws -> LoginModel
}

class LoginService: LoginServiceProtocol {
    static let shared: LoginServiceProtocol = LoginService()
    
    func getLogin(email: String, pass: String) async throws -> LoginModel {
        let url = AppURL.login
        let params = LoginRequest(email: email, passs: pass).params()
        return try await Service().requestNoToken(url: url, method: .post, params: params)
   }
}

struct LoginRequest: RequestParams {
    let email: String
    let passs: String
    
    func params() -> Params {
        return ["email": email,
                "password": passs]
    }
}
