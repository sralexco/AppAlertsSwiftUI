//
//  AlertsViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import Foundation
import Combine
import SwiftUI

class AlertsViewModel: BaseViewModel {
    @Published var items = [Alert_GetAlertsModel]()
    var service: AlertsServiceProtocol
    @Published var alertSelected: Alert_GetAlertsModel?
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var messageError: String = ""
    @Published var isEmpty: Bool = false
    @Published var isLocationEnabled: Bool = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    @StateObject var locationManager = LocationManager()
    
    init(service: AlertsServiceProtocol = AlertsService.shared) {
        self.service = service
    }
    
    func sendGetAlerts(){
        isLoading = true
        let date = Date().getFormattedDate(format: "yyyy-MM-dd")
        let latitude:Double = locationManager.manager.location?.coordinate.latitude ?? 0.0
        let longitude:Double = locationManager.manager.location?.coordinate.longitude ?? 0.0
        let request = GetAlertsRequest(lat: latitude,
                                       lon: longitude,
                                       date: date)
       /* service.getAlerts(data: request)
            .sink { (dataResponse) in
                print(dataResponse)
                self.isLoading = false
                guard dataResponse.error == nil else {
                    return self.showAlertService(with: dataResponse.error!) }
                self.getAlertsSuccess(obj:dataResponse.value!)
            }.store(in: &cancellableSet)
        if obj.status == 0 {
            items = obj.res!
            if items.count == 0 { isEmpty = true } else {
                isEmpty = false
            }
        } else {
            showAlertService(with: ServiceError("Invalid username and password Please try again"))
        }
        
        */
    }
  
    
}
