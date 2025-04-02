//
//  MapService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

protocol MapServiceProtocol {
    func listAlerts(lat: String, lon: String, date: String) async throws -> MapModel
}

class MapService: MapServiceProtocol {
    static let shared: MapServiceProtocol = MapService()
    
    func listAlerts(lat: String, lon: String, date: String) async throws -> MapModel {
        let url = AppURL.listAlerts
        let params = AlertsMARequest(lat: lat, lon: lon, date: date).params()
        return try await Service().request(url: url, method: .post, params: params)
   }
    
}

struct AlertsMARequest: RequestParams {
    let lat: String
    let lon: String
    let date: String
    
    func params() -> Params {
        return ["lat": lat,
                "lon": lon,
                "date": date]
    }
}
