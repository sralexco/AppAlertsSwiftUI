//
//  MainView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

struct MainView: View {
    @State private var path = [RouteMain]()
    //@StateObject var VM = MainViewModel()
    var body: some View {
        VStack {
            Text("Alertize")
                .font(.title)
                .foregroundColor(.green)
                .padding(.top, 100)
            Spacer()
            Button(action: loginAction, label: { Text("LOGIN") })
            .customStyle(.primary)
            Button(action: regiterAction, label: { Text("REGISTER") })
            .customStyle(.primary)
        }
    }
    private func loginAction() {
        path.append(.login)
    }
    private func regiterAction() {
        path.append(.login)
    }
}

enum RouteMain: Hashable {
    case login
    case register
}

#Preview {
    MainView()
}
