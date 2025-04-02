//
//  ProfileModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

struct ProfileModel: Codable {
    var status: Bool
    var data: [DataProfileModel]?
}

struct DataProfileModel: Codable {
    var id: Int
    var names: String
    var email: String
    var phone: String
    var image: String
    var country: String
    var password: String
}
