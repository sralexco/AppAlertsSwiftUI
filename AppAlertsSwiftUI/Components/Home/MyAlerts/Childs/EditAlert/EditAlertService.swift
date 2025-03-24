//
//  EditAlertService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//

protocol EditAlertServiceProtocol {
    func getAlert(id: String) async throws -> EditAlertModel
    func getAlertTypes() async throws -> AlertTypeModel
}

class EditAlertService: EditAlertServiceProtocol {
    static let shared: EditAlertServiceProtocol = EditAlertService()
    
    func getAlert(id: String) async throws -> EditAlertModel {
        let url = AppURL.getAlert(id: id)
        //let params = EditAlertRequest(id: id).params()
        return try await Service().request(url: url, method: .post, params: nil)
   }
    
    func updateeAlert(id:String, model: ParamsCAModel) async throws -> CreateAlertModel {
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
    let idUser: Int
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
        return ["id_user": model.idUser,
                "title": model.title,
                "description": model.description,
                "id_alert_type": model.idAlertType,
                "lat": model.lat,
                "lon": model.lon,
                "image": model.image]
    }
}
