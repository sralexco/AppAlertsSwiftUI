//
//  RegisterViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 8/03/25.
//

import Foundation
import Combine
import SwiftUI

class RegisterViewModel: BaseViewModel {
    @Published var name: String = ""
    @Published var nameError: Bool = false
    @Published var email: String = ""
    @Published var emailError: Bool = false
    @Published var pass: String = ""
    @Published var passError: Bool = false
    @Published var phone: String = ""
    @Published var phoneError: Bool = false
    @Published var country: String = ""
    @Published var countryError: Bool = false
    @Published var countries: [Country] = []
    @Published var selectedCountry = -1
    @Published var isLoading = false
    
    var goBack: (() -> Void)?
    var service: RegisterServiceProtocol
    
    init(service: RegisterServiceProtocol = RegisterService.shared) {
        self.service = service
        super.init()
        self.countries = getCountries()
    }
   
    func getCountries() -> [Country] {
        let excludedRegions: Set<String> = [
                  "001", "142", "150", "002", "019", "009", "143", "151", "154", "155",
                  "015", "013", "QO", "005", "014", "017", "018", "021", "061", "029",
                  "030", "034", "035", "039", "053", "054", "057", "145", "011"
              ]
        return Locale.Region.isoRegions
            .filter { !excludedRegions.contains($0.identifier) }
            .compactMap { region in
                guard let name = Locale.current.localizedString(forRegionCode: region.identifier) else { return nil }
                return Country(id: region.identifier, name: name)
            }
            .sorted { $0.name < $1.name }
    }
    
    func validateInputs() -> Bool {
        emailError  = email.isEmpty ? true : false
        passError = pass.isEmpty ? true : false
        nameError = name.isEmpty ? true : false
        phoneError = phone.isEmpty ? true : false
        countryError = country.isEmpty ? true : false
        
        if !emailError && !passError && !nameError && !phoneError && !countryError {
            return true
        } else {
            showAlert(title: "Alert", message: "Complete all the fields")
            return false
        }
    }
    
    func sendRegister() {
        if selectedCountry != -1 {
            country = countries[selectedCountry].name
        }
        guard validateInputs() else { return }
        isLoading = true
        Task {
        do {
            let obj = try await service.sendRegister(email: email, pass: pass, name: name, phone: phone,
                                                     country: country)
            await MainActor.run {
                if obj.status {
                    showAlert(title: "Success", message: "Create user successful") {
                        self.goBack?()
                    }
                } else {
                    showAlert(title: "Error", message: "Fill inputs and please try again")
                }
                isLoading = false
            }
        } catch {
            await MainActor.run {
                isLoading = false
                showAlert(title: "Error", message: error.localizedDescription)
            }
        }
        }
    }
    
}
