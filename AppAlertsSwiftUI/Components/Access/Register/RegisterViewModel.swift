//
//  RegisterViewModel.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 8/03/25.
//

import SwiftUI
import Combine

class RegisterViewModel: ObservableObject {
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
    
    init() {
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
    
}
