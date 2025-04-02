//
//  MapModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

struct MapModel: Codable {
    var status: Bool
    var alerts: [AlertMModel]?
}

struct AlertMModel: Codable {
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
