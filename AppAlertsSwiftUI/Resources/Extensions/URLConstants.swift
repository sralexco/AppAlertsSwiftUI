//
//  URLConstants.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 12/03/25.
//

import Foundation

struct AppURL {
    
    private struct Domains {
        // static let PRO = "http://192.168.18.9:8888"
        static let PRO = "http://localhost:3337"
    }
    
    private  struct Routes {
        static let Api = "/api/"
    }
    
    private static let Domain = Domains.PRO
    private static let Route = Routes.Api
    private static let BaseURL = Domain + Route
    
    static let login = BaseURL + "login"
    static let register = BaseURL + "user/create"
    
    /*
    static let alerts = BaseURL + "alert/list"
    
    static let getAlertsType = BaseURL + "alertType/list"
    static let createAlert = BaseURL + "alert/create"
    
    static let myAlerts = BaseURL + "alert/mylist"
    
    static func deleteAlert(id: String) -> String {
        return BaseURL + "alert/" + id + "/delete"
    }
    
    static func getAlert(id: String) -> String {
        return BaseURL + "alert/" + id
    }
    static func updateAlert(id: String) -> String {
        return BaseURL + "alert/" + id + "/update"
    }
    
    
    static func getUser(id: String) -> String {
        return BaseURL + "user/" + id
    }
    static func updateUser(id: String) -> String {
        return BaseURL + "user/" + id + "/update"
    }
    */
    
}
