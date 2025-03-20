//
//  DetailAlertModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

struct DetailAlertModel: Codable {
    var status: Bool
    var alert: DataDetailAlertModel?
}

struct DataDetailAlertModel: Codable {
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
    var type:String
    var author:String
}
