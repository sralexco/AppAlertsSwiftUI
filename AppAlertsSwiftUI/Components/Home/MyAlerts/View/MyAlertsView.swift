//
//  MyAlertsView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import SwiftUI

enum MyAlertsRoute: Hashable {
    case detail(id: Int)
   // case add
   // case choiseLocation
}

struct MyAlertsView: View {
    @StateObject var VM = MyAlertsViewModel()
    @State private var path = [MyAlertsRoute]()
    var title = "Alerts"
    init() { UIScrollView.appearance().bounces = false }
    
    var body: some View {
        NavigationStack(path: $path) {
        CustomNavView(title: "My Alerts", icon: "person.circle") {
            VStack(alignment: .center) {
                if VM.isEmpty {
                    AlertInfoView(text: "No alerts yet")
                }
                VStack {
                    ForEach(VM.items, id: \.id) { alert in
                    
                        AlertMAView(alert: alert)
                            .contextMenu {
                                Button(action: { editAction(id: alert.id) },
                                       label: { Text("Edit")})
                                Button(action: { deleteAction(id: alert.id) },
                                       label: { Text("Delete")})
                            }
                            .onTapGesture {
                                path.append(MyAlertsRoute.detail(id: alert.id)) }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 0, leading: 0, bottom: 14, trailing: 0))
                    }
                }.padding(.top, 10)
            }
            .background(Color.blue1.opacity(0.20))
            .onAppear { VM.requestMyAlerts() }
            .navigationDestination(for: MyAlertsRoute.self) { route in
                switch route {
                case let .detail(id):
                    DetailAlertMAView(alertID: id, path: $path)
                }
            }
            .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
            .loadingView(show: $VM.isLoading)
        }
        }
    }
    
    private func editAction(id: Int) {
       // VM.requestEditAlert(id: id)
    }
    
    private func deleteAction(id: Int) {
        VM.requestDeleteAlert(id: id)
    }
    
    
    
}
