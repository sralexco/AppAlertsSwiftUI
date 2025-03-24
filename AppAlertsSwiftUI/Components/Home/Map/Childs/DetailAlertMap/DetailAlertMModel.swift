//
//  DetailAlertMAModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

struct DetailAlertMModel: Codable {
    var status: Bool
    var alert: DataDetailAlertMModel?
}

struct DataDetailAlertMModel: Codable {
    var id: Int
    var idUser: Int
    var title: String
    var description: String
    var date: String
    var idAlertType: Int
    var lat: String
    var lon: String
    var country: String
    var city: String
    var image: String
    var type: String
    var author: String
}
