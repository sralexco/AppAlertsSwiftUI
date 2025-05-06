//
//  MainViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

class MainViewModel: BaseViewModel {
    @Published var isLogged: Bool = false
   
    func checkAccess() {
        let stateAccess = UserDefaults.standard.bool(forKey: "access")
        isLogged = stateAccess
    }
    
    func logout() {
        UserDefaults.standard.set(false, forKey: "access")
        isLogged = false
    }
    
}
