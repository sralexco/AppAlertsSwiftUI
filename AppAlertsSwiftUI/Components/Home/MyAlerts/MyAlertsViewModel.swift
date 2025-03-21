//
//  MyAlertsViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import SwiftUI

class MyAlertsViewModel: BaseViewModel {
    @Published var items = [DataMyAlertsModel]()
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    private var service: MyAlertsServiceProtocol
    
    init(service: MyAlertsServiceProtocol = MyAlertsService.shared) {
        self.service = service
    }
    
    // Service
    func requestMyAlerts() {
        isLoading = true
        let idUser: String = "1"
        Task {
        do {
            let obj = try await service.myAlerts(idUser:idUser)
            await MainActor.run {
                if obj.status {
                    isEmpty = obj.alerts?.count == 0 ? true : false
                    items = obj.alerts ?? []
                    /* for i in 0...10 {
                        items += obj.alerts ?? []
                    }
                    print("alerts", obj.alerts) */
                } else {
                    showAlert(title: "Error", message: "Try again more Later")
                }
                isLoading = false
            }
        } catch {
            await MainActor.run {
                showAlert(title: "Error", message: error.localizedDescription)
                isLoading = false
            }
        }
        }
    }
    
    func requestDeleteAlert(id:Int) {
        isLoading = true
        Task {
        do {
            let obj = try await service.deleteAlert(idAlert:"\(id)")
            await MainActor.run {
                if obj.status {
                    if let index = self.items.firstIndex(where: { $0.id == id }) {
                        items.remove(at: index)
                    }
                } else {
                    showAlert(title: "Error", message: "Try again more Later")
                }
                isLoading = false
            }
        } catch {
            await MainActor.run {
                showAlert(title: "Error", message: error.localizedDescription)
                isLoading = false
            }
        }
        }
    }
    
}
