//
//  AppStorage.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 6/05/25.
//
import SwiftUI

class AppStorage {
    func getUserID() -> Int {
        return UserDefaults.standard.integer(forKey: "idUser")
    }
}
