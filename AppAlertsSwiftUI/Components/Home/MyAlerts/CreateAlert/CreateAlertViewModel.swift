//
//  CreateAlertViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 21/03/25.
//

import SwiftUI

class CreateAlertViewModel: BaseViewModel {
    @Published var idUser: Int = -1
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var date: String = ""
    @Published var idAlertType: Int = -1
    @Published var lat: String = ""
    @Published var lon: String = ""
    @Published var image: String = ""
    @Published var isLoading: Bool = false
    
    @Published var titleError: Bool = false
    @Published var descriptionError: Bool = false
   
    @Published var types: [ItemAlertTypeModel] = []
    @Published var selectedType = 0
    @Published var selectedTypeError: Bool = false
    
    @Published var locationError: Bool = false
    @Published var imageError: Bool = false
    
    private var service: CreateAlertServiceProtocol
    
    init(service: CreateAlertServiceProtocol = CreateAlertService.shared) {
        self.service = service
        super.init()
        self.requestGetAlertTypes()
    }
    
    func requestGetAlertTypes() {
        print("is Call")
        isLoading = true
        Task {
        do {
            let res = try await service.getAlertTypes()
            await MainActor.run {
                if res.status {
                    guard let _types = res.types else {
                        return showAlert(title: "Error", message: "Try again more Later")}
                    types = _types
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
    
    func requestCreateAlert() {
        isLoading = true
        let model = ParamsCAModel(idUser: idUser, title: title, description: description, date: date,
                                  idAlertType: idAlertType,
                                  lat: lat, lon: lon, image: image)
        Task {
        do {
            let obj = try await service.createAlert(model: model)
            await MainActor.run {
                if obj.status {
                    showAlert(title: "Success", message: "Alert Created Sucessfully")
                    // Add callback to retun the my Alerts
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
