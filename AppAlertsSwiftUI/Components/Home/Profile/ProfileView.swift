//
//  ProfileView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var title = "Profile"
    @State private var photoItem: PhotosPickerItem?
    @StateObject var VM = ProfileViewModel()
    
    var body: some View {
        
        
        VStack(alignment: .center) {
            
            PhotosPicker(
                selection: $photoItem,
                matching: .images,
                photoLibrary: .shared()) {
                    if let _ = VM.photoImage {
                        VM.photoImage!
                            .resizable()
                            .frame(width: 140, height: 140)
                            .padding(.horizontal, 100)
                            .clipShape(Circle())
                    }
                }
                .onChange(of: photoItem) { newItem in
                    Task {
                        if let data = try? await photoItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                VM.photoImage = Image(uiImage: uiImage)
                                VM.imageEncode = uiImage.toBase64(format: .jpeg(0.3))
                                return
                            }
                        }
                        print("Failed")
                    }
                }
            
            FloatingTextFieldAlterTwo(title: "Names", text: $VM.names, isError: $VM.namesError, isDisabled: $VM.namesDisabled)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            
            FloatingTextFieldAlterTwo(title: "Email", text: $VM.email, isError: $VM.emailError, isDisabled: $VM.emailDisabled)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            
            FloatingTextFieldAlterTwo(title: "Password", text: $VM.pass, isError: $VM.passError, isDisabled: $VM.passDisabled, isSecure: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            
            FloatingTextFieldAlterTwo(title: "Telephone", text: $VM.phone, isError: $VM.phoneError, isDisabled: $VM.phoneDisabled, keyboardType: .numberPad, isNumber: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            
            FloatingTextFieldAlterTwo(title: "Country", text: $VM.country, isError: $VM.countryError, isDisabled: $VM.countryDisabled)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            
        }
        
    }
}
