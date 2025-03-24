//
//  EditAlertViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//
import SwiftUI

class EditAlertViewModel: BaseViewModel {
    @Published var id: Int = -1
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
    private var service: EditAlertServiceProtocol
    
    var goBack: (() -> Void)?
    
    init(service: EditAlertServiceProtocol = EditAlertService.shared) {
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
    
    func requestGetAlert() {
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
                    selectedType = alert.idAlertType
                    
                    let lat = alert.lat
                    let lon = alert.lon
                    location = "\(lat),\(lon)"
                    locationLat = "\(lat)"
                    locationLon = "\(lon)"
                    locationError = false
                    
                    imageEncode = alert.image
                    guard let uiImage = imageEncode?.imageFromBase64 else {
                        return
                    }
                    photoImage = Image(uiImage: uiImage)
                    textImage = "Selected"
                    
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
                    requestGetAlert()
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
