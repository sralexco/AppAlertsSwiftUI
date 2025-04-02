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
    
    func showAlert(title: String, message: String, action: (() -> Void)?) {
        DispatchQueue.main.async {
            self.activeAlert = AlertItem(
                alert: Alert(
                    title: Text(title),
                    message: Text(message),
                    dismissButton: .default(Text("OK"), action: action)
                )
            )
        }
    }
    
    func showAlert(title: String, message: String) {
        activeAlert = AlertItem(
            alert: Alert(
                title: Text(title),
                message: Text(message),
                dismissButton: .default(Text("OK")) // Remove action for testing
            )
        )
    }
    
}

struct AlertItem: Identifiable {
    let id = UUID()
    let alert: Alert
}
