//
//  MyMyAlertsService.swift
//  AppMyAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import Alamofire

protocol MyAlertsServiceProtocol {
    func myAlerts(idUser: String) async throws -> MyAlertsModel
}

class MyAlertsService: MyAlertsServiceProtocol {
    static let shared: MyAlertsServiceProtocol = MyAlertsService()
    
    func myAlerts(idUser: String) async throws -> MyAlertsModel {
        let url = AppURL.myAlerts
        let params = MyAlertsRequest(idUser: idUser).params()
        return try await Service().request(url: url, method: .post, params: params)
   }
}

struct MyAlertsRequest: RequestParams {
    let idUser: String
    
    func params() -> Params {
        return ["id_user": idUser]
    }
}
