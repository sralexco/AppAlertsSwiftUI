//
//  MapViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//
import SwiftUI
import Combine

class MapViewModel: BaseViewModel {
    @Published var items = [AlertMModel]()
    var service: MapServiceProtocol
  
    @Published var alertSelected: AlertMModel?
    
    @Published var isLoading: Bool = false
    @Published var isLocationEnabled: Bool = false
    @Published var isEmpty: Bool = false
    @Published  var locationManager = LocationManager()
    @Published var hideDetail: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager = LocationManager(), service: MapServiceProtocol = MapService.shared) {
        self.locationManager = locationManager
        self.service = service
        super.init()
        self.setupAuthorizationListener()
    }
    
    // Authorization
    func setupAuthorizationListener() {
        locationManager.$authorizationStatus
        .sink { [weak self] status in
            if status == .authorizedWhenInUse {
                self?.isLocationEnabled = true
                self?.requestGetAlerts()
            }
        }
        .store(in: &cancellables)
    }
    
    func getAuthorizationLocation() {
        _ = locationManager.manager.authorizationStatus
    }
    
    func requestGetAlerts() {
        isLoading = true
        let date = Date().getFormattedDate(format: "yyyy-MM-dd")
        let lat: String = "\(locationManager.manager.location?.coordinate.latitude ?? 0.0)"
        let lon: String = "\(locationManager.manager.location?.coordinate.longitude ?? 0.0)"
        
        Task {
        do {
            let obj = try await service.listAlerts(lat: lat, lon: lon, date: date)
            await MainActor.run {
                if obj.status {
                    isEmpty = obj.alerts?.count == 0 ? true : false
                    items = obj.alerts ?? []
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
