//
//  DetailDetailAlertervice.swift
//  AppDetailAlertSwiftUI
//
//  Created by alex on 20/03/25.
//

import Alamofire

protocol DetailAlertMAServiceProtocol {
    func getAlert(id: String) async throws -> DetailAlertMAModel
}

class DetailAlertMAService: DetailAlertMAServiceProtocol {
    static let shared: DetailAlertMAServiceProtocol = DetailAlertMAService()
    
    func getAlert(id: String) async throws -> DetailAlertMAModel {
        let url = AppURL.getAlert(id: id)
        return try await Service().request(url: url, method: .post, params: nil)
   }
}
