//
//  EditAlertService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

protocol EditAlertServiceProtocol {
    func getAlert(id: String) async throws -> EditAlertModel
    func updateAlert(id: String, model: ParamsUAModel) async throws -> UpdateAlertModel
    func getAlertTypes() async throws -> AlertTypeModel
}

class EditAlertService: EditAlertServiceProtocol {
    static let shared: EditAlertServiceProtocol = EditAlertService()
    
    func getAlert(id: String) async throws -> EditAlertModel {
        let url = AppURL.getAlert(id: id)
        return try await Service().request(url: url, method: .post, params: nil)
   }
    
    func updateAlert(id: String, model: ParamsUAModel) async throws -> UpdateAlertModel {
        let url = AppURL.updateAlert(id: id)
        let params = UpdateAlertRequest(model: model).params()
        return try await Service().request(url: url, method: .post, params: params)
   }
    
    func getAlertTypes() async throws -> AlertTypeModel {
        let url = AppURL.getAlertsType
        return try await Service().request(url: url, method: .post, params: nil)
   }
}

struct ParamsUAModel {
    let title: String
    let description: String
    let idAlertType: Int
    let lat: String
    let lon: String
    let image: String
}

struct UpdateAlertRequest: RequestParams {
    let model: ParamsUAModel
    
    func params() -> Params {
        return [
                "title": model.title,
                "description": model.description,
                "id_alert_type": model.idAlertType,
                "lat": model.lat,
                "lon": model.lon,
                "image": model.image]
    }
}
