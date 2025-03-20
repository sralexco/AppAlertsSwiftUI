//
//  Alerts.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import SwiftUI

enum Route: Hashable {
    case detail(id: Int)
   // case add
   // case choiseLocation
}

struct AlertsView: View {
    @StateObject var VM = AlertsViewModel()
    @State private var path = [Route]()
    var title = "Alerts"
    init() { UIScrollView.appearance().bounces = false }
    
    var body: some View {
        NavigationStack(path: $path) {
        VStack(alignment: .center) {
            if VM.locationManager.authorizationStatus != .authorizedAlways &&
                VM.locationManager.authorizationStatus != .authorizedWhenInUse {
                AlertInfoView(text: "You need to to allow location in configuration")
            }
            if VM.isEmpty {
                AlertInfoView(text: "No alerts yet")
            }
            List {
                ForEach(VM.items, id: \.id) { alert in
                    AlertView(alert: alert)
                        .onTapGesture {
                            print("tap")
                            path.append(Route.detail(id: alert.id)) }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowInsets(.init(top: 0, leading: 0, bottom: 16, trailing: 0))
                }
            }
        }
        .navigationBarHidden(true)
        .overlay { NavigationBar(title: title, showLeft: false) }
        .onAppear { VM.getAuthorizationLocation() }
        .navigationTitle("Alerts")
        .navigationDestination(for: Route.self) { route in
            switch route {
            case let .detail(id):
                DetailAlertView(alertID: id, path: $path)
            }
        }
        .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        .loadingView(show: $VM.isLoading)
    }
    }
}

#Preview {
    AlertsView()
}
