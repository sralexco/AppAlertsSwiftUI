//
//  LoginView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var VM = LoginViewModel()
    @Binding var path: [RouteMain]
    @StateObject private var loadingManager = LoadingManager()
    
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
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        .onAppear {
            VM.onLoginSuccess = {
                path.removeLast()
            }
        }
    }
    private func loginAction() {
        VM.getLogin()
    }
    
}

/*
#Preview {
    LoginView()
} */
