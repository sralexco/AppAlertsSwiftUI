//
//  RegisterModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import Foundation

struct RegisterModel: Codable {
    var status: Bool
    var user: UserRegisterModel?
    var message: String?
    var idError: Int?
}

struct UserRegisterModel: Codable {
    var id: Int = -1
    var email: String = ""
    var name: String = ""
    var phone: String = ""
    var country: String = ""
}
