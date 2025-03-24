//
//  ProfileViewMode.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//
import SwiftUI

class ProfileViewModel: BaseViewModel {
    
    @Published var isLoading: Bool = false
    
    @Published var names: String = ""
    @Published var namesError: Bool = false
    @Published var namesDisabled: Bool = true
    @Published var phone: String = ""
    @Published var phoneError: Bool = false
    @Published var phoneDisabled: Bool = true
    @Published var country: String = ""
    @Published var countryError: Bool = false
    @Published var countryDisabled: Bool = true
    @Published var email: String = ""
    @Published var emailError: Bool = false
    @Published var emailDisabled: Bool = true
    @Published var pass: String = ""
    @Published var passError: Bool = false
    @Published var passDisabled: Bool = true
    
    @Published var hideUpdateButton: Bool = true
    
    @Published var photoImage: Image?
    @Published var imageEncode:String?
    @Published var imageError: Bool = false
    
    init(service: ProfileServiceProtocol = ProfileService.shared) {
        self.service = service
        photoImage = Image("profile")
        requestGetUser()
    }
    
    
    
}

