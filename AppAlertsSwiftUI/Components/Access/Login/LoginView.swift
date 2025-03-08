//
//  LoginView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var passError: Bool = false
    @StateObject var VM = LoginViewModel()
    @Binding var path: [RouteMain]
    var body: some View {
        VStack {
            FloatingTextField(title: "Email", text: $VM.email, isError: $VM.emailError, keyboardType: .emailAddress)
                .padding(.init(top: 30, leading: 20, bottom: 0, trailing: 20 ))
            FloatingTextField(title: "Password", text: $VM.pass, isError: $VM.passError, isSecure: true)
                .padding(.init(top: 20, leading: 20, bottom: 0, trailing: 20 ))
            Button(action: loginAction,
                   label: { Text("Login")})
                .customStyle(.primary)
                .padding(.top, 20)
            Spacer()
        }
        .navigationTitle("Login")
    }
    private func loginAction(){ print("Act") }
}

/*
#Preview {
    LoginView()
} */
