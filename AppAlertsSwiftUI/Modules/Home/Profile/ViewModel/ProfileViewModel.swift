//
//  ProfileViewMode.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//
import SwiftUI

class ProfileViewModel: BaseViewModel {
    @Published var names: String = ""
    @Published var namesError: Bool = false
    @Published var namesDisabled: Bool = true
    @Published var phone: String = ""
    @Published var phoneError: Bool = false
    @Published var phoneDisabled: Bool = true
    
    @Published var country: String = ""
    @Published var countryError: Bool = false
    @Published var countryDisabled: Bool = true
    @Published var countries: [Country] = []
    @Published var selectedCountry = -1
    
    @Published var email: String = ""
    @Published var emailError: Bool = false
    @Published var emailDisabled: Bool = true
    @Published var pass: String = ""
    @Published var passError: Bool = false
    @Published var passDisabled: Bool = true
    
    @Published var hideEditButton: Bool = false
    @Published var hideUpdateButton: Bool = true
    
    @Published var photoImage: Image?
    @Published var imageEncode: String?
    @Published var imageError: Bool = false
    
    private var service: ProfileServiceProtocol
    
    @Published var isLoading: Bool = false
    
    init(service: ProfileServiceProtocol = ProfileService.shared) {
        self.service = service
        photoImage = Image("profile")
        super.init()
        self.requestGetUser()
        self.countries = getCountries()
    }
    
    func enabledFields() {
        namesDisabled = false
        phoneDisabled = false
        passDisabled = false
        countryDisabled = false
        hideUpdateButton = false
    }
    
    func disableFields() {
        namesDisabled = true
        phoneDisabled = true
        passDisabled = true
        countryDisabled = true
        hideUpdateButton = true
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
    
    func validations() -> Bool {
        var msgError = "Complete all the fields"
        namesError = names.isEmpty ? true : false
        phoneError = phone.isEmpty ? true : false
        
        if !pass.isEmpty {
            if pass.count < 3 {
                passError = true
            }
        } else {
            passError = false
        }
        
        if !names.isEmpty, names.contains(where: { $0.isNumber }) {
            namesError = true
            msgError = "Names can only contain letters"
        }
        
        if !phone.isEmpty, phone.contains(where: { $0.isLetter }) {
            phoneError = true
            msgError = "Phone can only contain numbers"
        }
        
        if !passError && !namesError && !phoneError {
            return true
        } else {
            showAlert(title: "Alert", message: msgError)
            return false
        }
    }
    
    func requestGetUser() {
        let id = AppStorage().getUserID()
        isLoading = true
        Task {
        do {
            let obj = try await service.getUser(id: "\(id)")
            await MainActor.run {
                if obj.status {
                    guard let user = obj.user else {
                        return showAlert(title: "Error", message: "Try again more Later")
                    }
                    names = user.name
                    phone = user.phone
                    country = user.country
                    email = user.email
                    selectedCountry = self.countries.firstIndex(where: { $0.name == user.country }) ?? 0
                    
                    imageEncode = user.image
                    guard let uiImage = imageEncode?.imageFromBase64 else {
                        isLoading = false
                        return
                    }
                    photoImage = Image(uiImage: uiImage)
                    
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
    
    func requestUpdateUser() {
        let id = 1
        guard validations() else { return }
   
        let country = countries[selectedCountry].name
        
        isLoading = true
        let model = DataUserModel(id: id, email: email, name: names,
                                  phone: phone, country: country, image: imageEncode ?? "",
                                  password: pass)
     
        Task {
        do {
            let obj = try await service.updateUser(id: "\(id)", model: model)
            await MainActor.run {
                if obj.status {
                    showAlert(title: "Success", message: "User Updated Sucessfully")
                } else {
                    showAlert(title: "Error", message: "Try again more Later")
                }
                isLoading = false
                hideEditButton = false
                disableFields()
            }
        } catch {
            await MainActor.run {
                showAlert(title: "Error", message: error.localizedDescription)
                isLoading = false
            }
        }
        }
    }
    
    func logout() {
        NotificationCenter.default.post(name: NSNotification.Name.logout,
                                        object: nil, userInfo: [:])
    }
}

extension Notification.Name {
    static let logout = Notification.Name("logout")
}
