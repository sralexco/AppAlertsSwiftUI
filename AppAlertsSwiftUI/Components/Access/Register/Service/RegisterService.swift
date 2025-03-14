//
//  RegisterService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import Foundation
import Combine
import Alamofire

protocol RegisterServiceProtocol {
    func sendRegister(email: String, pass: String, name: String, phone: String, country: String)
                        async throws -> RegisterModel
}

class RegisterService: RegisterServiceProtocol {
    static let shared: RegisterServiceProtocol = RegisterService()
    
    func sendRegister(email: String, pass: String, name: String, phone: String, country: String)
                        async throws -> RegisterModel {
        let url = AppURL.register
        let params = RegisterRequest(email: email, pass: pass, name: name, phone: phone, country: country).params()
        return try await Service().requestNoToken(url: url, method: .post, params: params)
   }
}

struct RegisterRequest: RequestParams {
    let email: String
    let pass: String
    let name: String
    let phone: String
    let country: String
    
    func params() -> Params {
        return ["email": email,
                "password": pass,
                "name": name,
                "phone": phone,
                "country": country]
    }
}
