//
//  ProfileService.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//
import SwiftUI

protocol ProfileServiceProtocol {
    func getUser(id: String) async throws -> UserModel
    func updateUser(id: String, model: DataUserModel) async throws -> UpdateUserModel
}

class ProfileService: ProfileServiceProtocol {
    static let shared: ProfileServiceProtocol = ProfileService()
    
    func getUser(id: String) async throws -> UserModel {
        let url = AppURL.getUser(id: id)
        return try await Service().request(url: url, method: .post, params: nil)
   }
    
    func updateUser(id: String, model: DataUserModel) async throws -> UpdateUserModel {
        let url = AppURL.updateUser(id: id)
        let params = UpdateUserRequestParams(model: model).params()
        // print("params", params)
        return try await Service().request(url: url, method: .post, params: params)
   }
}

struct UpdateUserRequestParams: RequestParams {
    let model: DataUserModel
    
    func params() -> Params {
        var parameters: Params = [
                "name": model.name,
                "email": model.email,
                "phone": model.phone,
                "country": model.country,
                "image": model.image]
        
        if let password = model.password {
            if !password.isEmpty {
                parameters["password"] = password
            }
        }
        return parameters
    }
}
