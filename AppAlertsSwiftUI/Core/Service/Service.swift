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
    
    func request<T>(url: String, method: HTTPMethod, params: Params? = nil)
            -> AnyPublisher<DataResponse<T, Error>, Never> where T: Codable {
        let token = UserDefaults.standard.string(forKey: "token") ?? ""
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
        ]
        // Debug
        /*print(url)
        print(params?.description)
        print(method) */
        
        let encoding: ParameterEncoding! = JSONEncoding.default
        
        return AF.request(url,
                          method: method,
                          parameters: params,
                          encoding: encoding,
                          headers: headers)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    // Debug
                    print("ERROR")
                    print(error)
                    print(error.localizedDescription)
                    return ServiceError("Connection error, please try again later.")
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func requestNoToken<T>(url: String, method: HTTPMethod, params: Params? = nil)
            -> AnyPublisher<DataResponse<T, Error>, Never> where T: Codable {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        // Debug
        /* print(url)
        print(params?.description)
        print(method) */
        
        let encoding: ParameterEncoding! = JSONEncoding.default
        
        return AF.request(url,
                          method: method,
                          parameters: params,
                          encoding: encoding,
                          headers: headers)
            .validate()
            .publishDecodable(type: T.self)
            .map { response in
                response.mapError { error in
                    // Debug
                    print("ERROR")
                    print(error)
                    print(error.localizedDescription)
                    return ServiceError("Connection error, please try again later.")
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
