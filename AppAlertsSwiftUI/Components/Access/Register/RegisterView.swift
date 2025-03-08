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
    var body: some View {
        VStack {
            FloatingTextField(title: "Name", text: $VM.name, isError: $VM.nameError, keyboardType: .emailAddress)
                .padding(.init(top: 30, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Email", text: $VM.email, isError: $VM.emailError, keyboardType: .emailAddress)
                .padding(.init(top: 30, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Password", text: $VM.pass, isError: $VM.passError, isSecure: true)
                .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20 ))
            //FloatingTextField(title: "Country", text: $VM.pass, isError: $VM.passError, isSecure: true)
              //  .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Telephone", text: $VM.phone, isError: $VM.phoneError, isSecure: true)
                .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20 ))
            Button(action: loginAction,
                   label: { Text("Register")})
                .customStyle(.primary)
                .padding(.top, 60)
            Spacer()
        }
        .navigationTitle("Register")
    }
    private func loginAction(){ print("Error") }
}
