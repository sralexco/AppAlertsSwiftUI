//
//  BaseViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 12/03/25.
//

import SwiftUI
import Combine

class BaseViewModel: ObservableObject {
    @Published var activeAlert: AlertItem?
    
    func showAlert(title: String, message: String, action: (() -> Void)? = nil) {
        activeAlert = AlertItem(
                  alert: Alert(
                      title: Text(title),
                      message: Text(message),
                      dismissButton: .default(Text("OK"), action: action)
                  )
       )
    }
}

struct AlertItem: Identifiable {
    let id = UUID()
    let alert: Alert
}
