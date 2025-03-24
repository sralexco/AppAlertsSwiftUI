//
//  ProfileService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

protocol ProfileServiceProtocol {
    func getUser(id:String) async throws -> UserModel
    func updateUser(model: UserParamsModel) async throws -> UpdateUserModel
}

class ProfileService: ProfileServiceProtocol {
    static let shared: ProfileServiceProtocol = ProfileService()
    
    func getUser(id: String) async throws -> ProfileModel {
        let url = AppURL.Profile
        let params = ProfileRequest(model: model).params()
        return try await Service().request(url: url, method: .post, params: nil)
   }
    
    func updateUser(model: UserModel) async throws -> UpdateUserModel {
        let url = AppURL.getAlertsType
        let params = ProfileRequest(model: model).params()
        return try await Service().request(url: url, method: .post, params: nil)
   }
}


struct ProfileRequest: RequestParams {
    let model: UserModel
    
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
