//
//  CreateAlertService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 21/03/25.
//

protocol CreateAlertServiceProtocol {
    func createAlert(model: ParamsCAModel) async throws -> CreateAlertModel
    func getAlertTypes() async throws -> AlertTypeModel
}

class CreateAlertService: CreateAlertServiceProtocol {
    static let shared: CreateAlertServiceProtocol = CreateAlertService()
    
    func createAlert(model: ParamsCAModel) async throws -> CreateAlertModel {
        let url = AppURL.createAlert
        let params = CreateAlertRequest(model: model).params()
        return try await Service().request(url: url, method: .post, params: params)
   }
    
    func getAlertTypes() async throws -> AlertTypeModel {
        let url = AppURL.getAlertsType
        return try await Service().request(url: url, method: .post, params: nil)
   }
}

struct ParamsCAModel {
    let idUser: Int
    let title: String
    let description: String
    let date: String
    let idAlertType: Int
    let lat: String
    let lon: String
    let image: String
}

struct CreateAlertRequest: RequestParams {
    let model: ParamsCAModel
    
    func params() -> Params {
        return ["id_user": model.idUser,
                "title": model.title,
                "description": model.description,
                "date": model.date,
                "id_alert_type": model.idAlertType,
                "lat": model.lat,
                "lon": model.lon,
                "image": model.image]
    }
}
