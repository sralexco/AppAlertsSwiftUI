//
//  Untitled.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 8/03/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var VM = RegisterViewModel()
    @Binding var path: [RouteMain]
    @EnvironmentObject var loadingManager: LoadingManager
    
    var body: some View {
        VStack {
            FloatingTextField(title: "Name", text: $VM.name, isError: $VM.nameError, keyboardType: .emailAddress)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Email", text: $VM.email, isError: $VM.emailError, keyboardType: .emailAddress)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Password", text: $VM.pass, isError: $VM.passError, isSecure: true)
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
            })
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Phone", text: $VM.phone, isError: $VM.phoneError, keyboardType: .numberPad,
                              isNumber: true)
                .padding(.init(top: 10, leading: 20, bottom: 0, trailing: 20 ))
            Button(action: registerAction,
                   label: { Text("Register")})
                .customStyle(.primary)
                .padding(.top, 40)
            Spacer()
        }
        .navigationTitle("Register")
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        .onAppear {
           VM.goBack = { path.removeLast() }
        }
    }
    
    private func registerAction() {
        VM.sendRegister()
    }
    
}

struct Country {
    var id: String
    var name: String
}
