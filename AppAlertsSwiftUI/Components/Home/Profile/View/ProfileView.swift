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
    @EnvironmentObject var loadingManager: LoadingManager
    
    var body: some View {
        VStack(alignment: .center) {
            ProNavBar(title: "Profile", hasRightOptions: true, imageRight: "ic_edit", callbackRight: {
                enableFieldsAction()
            })
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
                .onChange(of: photoItem) { _, newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                VM.photoImage = Image(uiImage: uiImage)
                                VM.imageEncode = uiImage.toBase64(format: .jpeg(0.3))
                                return
                            }
                        }
                    }
                }
                .padding(.top, 10)
            
            FloatingTextFieldAlterTwo(title: "Names", text: $VM.names, isError: $VM.namesError,
                                      isDisabled: $VM.namesDisabled)
                .padding(.init(top: 30, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextFieldAlterTwo(title: "Email", text: $VM.email, isError: $VM.emailError,
                                      isDisabled: $VM.emailDisabled)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextFieldAlterTwo(title: "Password", text: $VM.pass, isError: $VM.passError,
                                      isDisabled: $VM.passDisabled, isSecure: true)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextFieldAlterTwo(title: "Telephone", text: $VM.phone, isError: $VM.phoneError,
                                      isDisabled: $VM.phoneDisabled, keyboardType: .numberPad, isNumber: true)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextFieldAlter(title: "Country", isError: $VM.countryError, content: {
                Menu {
                    Picker(selection: $VM.selectedCountry) {
                        Text("Select Country").tag(-1)
                        ForEach(0..<VM.countries.count, id: \.self) { i in
                            Text(VM.countries[i].name).padding(.leading, -50)
                        }
                    } label: {}
                        
                } label: {
                    if VM.selectedCountry == -1 {
                        Text("Select Country")
                            .customStyle(.placeholder)
                            .padding(.top, 2)
                    } else {
                        Text(VM.countries[VM.selectedCountry].name)
                            .customStyle(.textfield)
                            .padding(.top, 2)
                    }
                }
                .allowsHitTesting(!VM.countryDisabled)
            })
            .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            
            Button(action: updateAction, label: { Text("Update")})
                .customStyle(.primary)
                .padding(.top, 20)
                .padding(.bottom, 20)
                .opacity(VM.hideUpdateButton ? 0 : 1 )
            
            Spacer()
            
        }
         .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
         .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        
    }
    
    private func updateAction() {
        VM.requestUpdateUser()
    }
    
    private func enableFieldsAction() {
        VM.enabledFields()
    }
    
}
