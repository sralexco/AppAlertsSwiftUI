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
    func getLogin(email: String, pass: String) -> AnyPublisher<DataResponse<LoginModel, Error>, Never>
}

class LoginService {
    static let shared: LoginServiceProtocol = LoginService()
}

extension LoginService: LoginServiceProtocol {
    func getLogin(email: String, pass: String) -> AnyPublisher<DataResponse<LoginModel, Error>, Never> {
        let url = AppURL.login
        let params = LoginRequest(email: email, passs: pass).params()
        return Service().requestNoToken(url: url, method: .post, params: params)
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
