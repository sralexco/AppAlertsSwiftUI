//
//  MyAlertsModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

struct MyAlertsModel: Codable {
    var status: Bool
    var alerts: [DataMyAlertsModel]?
}

struct DataMyAlertsModel: Codable {
    var id: Int
    var title: String
    var description: String
    var date: String
    var idAlertType: Int
    var lat: String
    var lon: String
    var country: String
    var city: String
}
