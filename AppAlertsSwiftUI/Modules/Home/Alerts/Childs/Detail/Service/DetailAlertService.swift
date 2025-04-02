//
//  DetailDetailAlertervice.swift
//  AppDetailAlertSwiftUI
//
//  Created by alex on 20/03/25.
//

import Alamofire

protocol DetailAlertServiceProtocol {
    func getAlert(id: String) async throws -> DetailAlertModel
}

class DetailAlertService: DetailAlertServiceProtocol {
    static let shared: DetailAlertServiceProtocol = DetailAlertService()
    
    func getAlert(id: String) async throws -> DetailAlertModel {
        let url = AppURL.getAlert(id: id)
        return try await Service().request(url: url, method: .post, params: nil)
   }
}
