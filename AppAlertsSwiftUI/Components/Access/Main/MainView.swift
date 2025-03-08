//
//  MainView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

enum RouteMain: Hashable {
    case login
    case register
}

struct MainView: View {
    @State private var path = [RouteMain]()
    //@StateObject var VM = MainViewModel()
    var body: some View {
        NavigationStack(path: $path) {
        VStack {
            Text("Alertize")
                .customStyle(.primary)
                .padding(.top, 100)
            Spacer()
            Button(action: loginAction,
                   label: { Text("LOGIN") })
                .customStyle(.primary)
            Button(action: regiterAction,
                   label: { Text("REGISTER") })
                .customStyle(.primary)
                .padding(.top, 20)
        }
        .background(.green)
        .navigationTitle("")
        .navigationDestination(for: RouteMain.self) { route in
                switch route {
                case .login:
                    LoginView(path: $path)
                case .register:
                    RegisterView(path: $path)
                }
            }
        }
    }
    private func loginAction() {
        path.append(.login)
    }
    private func regiterAction() {
        path.append(.register)
    }
}

#Preview {
    MainView()
}
