//
//  CreateAlertViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 21/03/25.
//

import SwiftUI

class CreateAlertViewModel: BaseViewModel {
    @Published var title: String = ""
    @Published var titleError: Bool = false
    
    @Published var description: String = ""
    @Published var descriptionError: Bool = false
    
    @Published var types: [ItemAlertTypeModel] = []
    @Published var selectedType = 0
    @Published var selectedTypeError: Bool = false
    
    @Published var location: String = "Select location"
    @Published var locationLat: String = ""
    @Published var locationLon: String = ""
    @Published var locationError: Bool = false
    
    @Published var textImage: String = "Select a photo"
    @Published var photoImage: Image?
    @Published var imageEncode: String?
    @Published var imageError: Bool = false
    
    @Published var isLoading: Bool = false
    private var service: CreateAlertServiceProtocol
    
    var goBack: (() -> Void)?
    
    init(service: CreateAlertServiceProtocol = CreateAlertService.shared) {
        self.service = service
        super.init()
        self.requestGetAlertTypes()
    }
    
    /// Validation
    func validations() -> Bool {
        titleError  = title.isEmpty ? true : false
        descriptionError = description.isEmpty ? true : false
        locationError = (location == "Select location") ? true : false
        if !titleError && !descriptionError && !locationError && locationLat != "0.0" && locationLon != "0.0" {
            return true
        } else {
            return false
        }
    }
    
    /// Requests
    func requestGetAlertTypes() {
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
        guard validations() else { return showAlert(title: "Error", message: "Complete all the fields") }
        let idUser = 1  // GG
        let date = Date().getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
        let type = types[selectedType]
        isLoading = true
        let model = ParamsCAModel(idUser: idUser, title: title, description: description, date: date,
                                  idAlertType: type.id,
                                  lat: locationLat, lon: locationLon, image: imageEncode ?? "")
        Task {
        do {
            let obj = try await service.createAlert(model: model)
            await MainActor.run {
                if obj.status {
                    showAlert(title: "Success", message: "Alert Created Sucessfully", action: {
                        self.goBack?()
                    })
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
