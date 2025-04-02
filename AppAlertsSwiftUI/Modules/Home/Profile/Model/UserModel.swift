//
//  UserModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

struct UserModel: Codable {
    var status: Bool
    var user: DataUserModel?
}

struct DataUserModel: Codable {
    var id: Int
    var email: String
    var name: String
    var phone: String
    var country: String
    var image: String
    var password: String?
}
