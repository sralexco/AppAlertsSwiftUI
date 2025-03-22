//
//  AlertTypeModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 22/03/25.
//

struct AlertTypeModel: Codable {
    let status: Bool
    let types: [ItemAlertTypeModel]?
}

struct ItemAlertTypeModel: Codable {
    let id: Int
    let title: String
}
