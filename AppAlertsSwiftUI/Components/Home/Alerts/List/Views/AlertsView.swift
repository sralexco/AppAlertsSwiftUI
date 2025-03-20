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
        CustomNavView(title: "Alerts", icon: "person.circle") {
            VStack(alignment: .center) {
                if VM.locationManager.authorizationStatus != .authorizedAlways &&
                    VM.locationManager.authorizationStatus != .authorizedWhenInUse {
                    AlertInfoView(text: "You need to to allow location in configuration")
                }
                if VM.isEmpty {
                    AlertInfoView(text: "No alerts yet")
                }
                VStack{
                    ForEach(VM.items, id: \.id) { alert in
                        AlertView(alert: alert)
                            .onTapGesture {
                                path.append(Route.detail(id: alert.id)) }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 14, trailing: 0))
                    }
                }.padding(.top, 10)
            }
            .background(Color.blue1.opacity(0.20))
            .onAppear { VM.getAuthorizationLocation() }
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
}

#Preview {
    AlertsView()
}
