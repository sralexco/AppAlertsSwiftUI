//
//  Alerts.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import SwiftUI

enum Route: Hashable {
    case detail(id: Int)
}

struct AlertsView: View {
    @EnvironmentObject var loadingManager: LoadingManager
    @StateObject var VM = AlertsViewModel()
    @State private var path = [Route]()
    var title = "Alerts"
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationStack(path: $path) {
         
                ZStack {
                    if VM.locationManager.authorizationStatus != .authorizedAlways &&
                        VM.locationManager.authorizationStatus != .authorizedWhenInUse {
                        AlertInfoView(text: "You need to to allow location in configuration")
                    }
                    if VM.isEmpty {
                        AlertInfoView(text: "No alerts yet")
                    }
                    VStack {
                            ProNavBar(title: "Alerts")
                            List(VM.items, id: \.id) { alert in
                                AlertView(alert: alert)
                                    .onTapGesture {
                                        path.append(Route.detail(id: alert.id)) }
                                    .listRowSeparator(.hidden)
                                    .listRowInsets(.init(top: 10, leading: 10,
                                                         bottom: alert.id == VM.items.last?.id ? 10 : 0,
                                                         trailing: 10))
                                    .listRowBackground(Color.clear)
                            }
                            .listStyle(.plain)
                            .background(Color.blue1.opacity(0.20))
                            .onAppear { VM.getAuthorizationLocation() }
                            .navigationDestination(for: Route.self) { route in
                                switch route {
                                case let .detail(id):
                                    DetailAlertView(alertID: id, path: $path)
                                }
                            }
                    }
                        
                }
                .onAppear { VM.requeestListAlerts() }
                .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
                .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        }
    }
}

#Preview {
    AlertsView()
}
