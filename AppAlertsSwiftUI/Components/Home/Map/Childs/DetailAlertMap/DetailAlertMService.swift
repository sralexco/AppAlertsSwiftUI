//
//  DetailAlertMA.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

protocol DetailAlertMServiceProtocol {
    func getAlert(id: String) async throws -> DetailAlertMModel
}

class DetailAlertMService: DetailAlertMServiceProtocol {
    static let shared: DetailAlertMServiceProtocol = DetailAlertMService()
    
    func getAlert(id: String) async throws -> DetailAlertMModel {
        let url = AppURL.getAlert(id: id)
        return try await Service().request(url: url, method: .post, params: nil)
   }
}
