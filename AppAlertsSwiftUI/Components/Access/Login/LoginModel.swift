//
//  LoginModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import Foundation

struct LoginModel: Codable {
    var id: Int?
    var email: String?
    var token: TokenLoginModel?
    var status: Bool
    var message: String?
    var idError: Int?
}

struct TokenLoginModel: Codable {
    var token: String = ""
}
