//
//  DetailAlertViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import SwiftUI

class DetailAlertViewModel: BaseViewModel {
    @Published var id: Int = -1
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var address: String = ""
    @Published var date: String = ""
    @Published var image: String = ""
    @Published var type: String = ""
    @Published var author: String = ""
    @Published var isLoading: Bool = false
    private var service: DetailAlertServiceProtocol
    
    init(service: DetailAlertServiceProtocol = DetailAlertService.shared) {
        self.service = service
    }
    
    func requestGetAlert() {
        print("requestGetAlert")
        isLoading = true
        Task {
        do {
            let obj = try await service.getAlert(id: "\(id)")
            await MainActor.run {
                if obj.status {
                    guard let alert = obj.alert else {
                        return showAlert(title: "Error", message: "Try again more Later")
                    }
                    title = alert.title
                    description = alert.description
                    let localDate = Date().convertUTCtoLocal(format: "yyyy-MM-dd HH:mm:ss", date: alert.date)
                    date = Date().byFormat(format: "dd/MM/YY HH:mm", date: localDate)
                    address = alert.city + " - " + alert.country
                    
                    image = alert.image
                    type = alert.type
                    author = alert.author
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
