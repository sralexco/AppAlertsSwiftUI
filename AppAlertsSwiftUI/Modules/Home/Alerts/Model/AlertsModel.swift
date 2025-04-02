//
//  AlertsModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//
struct AlertsModel: Codable {
    var status: Bool
    var alerts: [AlertModel]?
}

struct AlertModel: Codable {
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
