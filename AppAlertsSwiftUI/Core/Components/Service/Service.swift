//
//  Service.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 12/03/25.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

typealias Params = [String: Any]

protocol RequestParams {
    func params() -> Params
}

struct ServiceError: LocalizedError {
    let description: String

    init(_ description: String) {
        self.description = description
    }

    var errorDescription: String? {
        description
    }
}

class Service {
    
    func request<T: Decodable>(url: String, method: HTTPMethod, params: Params? = nil) async throws -> T {
          let token = UserDefaults.standard.string(forKey: "token") ?? ""
          print("token", token)
          //let token = "oat_MQ.amJveVh1bm90VFdOeUwzeEgtS2lHZjQ0dlp0d2U1WVdsSmpLMGFjRzIwMTUxMjA4Nzk"
          let headers: HTTPHeaders = [
              "Accept": "application/json",
              "Content-Type": "application/json",
              "Authorization": "Bearer \(token)"
          ]
        
        // Debug
        /*print(url)
        print(params?.description)
        print(method) */
          
          return try await withCheckedThrowingContinuation { continuation in
              AF.request(url,
                         method: method,
                         parameters: params,
                         encoding: JSONEncoding.default,
                         headers: headers)
                  .validate()
                  .responseDecodable(of: T.self) { response in
                      print("The resposen", response)
                      switch response.result {
                      case .success(let value):
                          continuation.resume(returning: value)
                      case .failure(let error):
                          continuation.resume(throwing: ServiceError(error.localizedDescription))
                      }
                  }
          }
      }
      
      func requestNoToken<T: Decodable>(url: String, method: HTTPMethod, params: Params? = nil) async throws -> T {
          let headers: HTTPHeaders = [
              "Accept": "application/json",
              "Content-Type": "application/json"
          ]
          
          // Debug
          /*print(url)
          print(params?.description)
          print(method) */
          
          return try await withCheckedThrowingContinuation { continuation in
              AF.request(url,
                         method: method,
                         parameters: params,
                         encoding: JSONEncoding.default,
                         headers: headers)
                  .validate()
                  .responseDecodable(of: T.self) { response in
                      switch response.result {
                      case .success(let value):
                          continuation.resume(returning: value)
                      case .failure(let error):
                          continuation.resume(throwing: ServiceError(error.localizedDescription))
                      }
                  }
          }
      }
    
}
