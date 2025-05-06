//
//  AlertsViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import SwiftUI
import CoreLocation
import Combine

class AlertsViewModel: BaseViewModel {
    @Published var items = [AlertModel]()
   
    @Published var isLoading: Bool = false
    @Published var isEmpty: Bool = false
    @Published var isLocationEnabled: Bool = false
   
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    
    @Published var locationManager: LocationManager = LocationManager()
    private var service: AlertsServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(locationManager: LocationManager = LocationManager(), service: AlertsServiceProtocol = AlertsService.shared) {
        self.locationManager = locationManager
        self.service = service
        super.init()
        setupAuthorizationListener()
    }
    
    // Authorization
    func setupAuthorizationListener() {
        locationManager.$authorizationStatus
        .sink { [weak self] status in
            if status == .authorizedWhenInUse {
                self?.isLocationEnabled = true
                self?.requeestListAlerts()
            }
        }
        .store(in: &cancellables)
    }
    
    func getAuthorizationLocation() {
        _ = locationManager.manager.authorizationStatus
    }
    
    // Service
    func requeestListAlerts() {
        guard isLocationEnabled else {
            return
        }
        
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
