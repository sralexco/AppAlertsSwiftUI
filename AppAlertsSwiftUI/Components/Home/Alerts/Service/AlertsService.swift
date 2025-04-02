//
//  AlertService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import Alamofire

protocol AlertsServiceProtocol {
    func listAlerts(lat: String, lon: String, date: String) async throws -> AlertsModel
}

class AlertsService: AlertsServiceProtocol {
    static let shared: AlertsServiceProtocol = AlertsService()
    
    func listAlerts(lat: String, lon: String, date: String) async throws -> AlertsModel {
        let url = AppURL.listAlerts
        let params = AlertsRequest(lat: lat, lon: lon, date: date).params()
        return try await Service().request(url: url, method: .post, params: params)
   }
}

struct AlertsRequest: RequestParams {
    let lat: String
    let lon: String
    let date: String
    
    func params() -> Params {
        return ["lat": lat,
                "lon": lon,
                "date": date]
    }
}
