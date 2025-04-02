//
//  MyAlertsView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 20/03/25.
//

import SwiftUI

enum MyAlertsRoute: Hashable {
    case detail(id: Int)
    case add
    case edit(id: Int)
    case choiseLocation
}

struct MyAlertsView: View {
    @StateObject var VM = MyAlertsViewModel()
    @State private var path = [MyAlertsRoute]()
    @EnvironmentObject var loadingManager: LoadingManager
    var title = "Alerts"
    init() { UIScrollView.appearance().bounces = false }
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if VM.isEmpty {
                    AlertInfoView(text: "No alerts yet")
                }
                
                VStack {
                    ProNavBar(title: "My Alerts", hasRightOptions: true, imageRight: "ic_add", callbackRight: {
                        path.append(MyAlertsRoute.add)
                    })
                    List(VM.items, id: \.id) { alert in
                        AlertMAView(alert: alert)
                            .contextMenu {
                                Button(action: { editAction(id: alert.id) },
                                       label: { Text("Edit")})
                                Button(action: { deleteAction(id: alert.id) },
                                       label: { Text("Delete")})
                            }
                            .onTapGesture {
                                path.append(MyAlertsRoute.detail(id: alert.id)) }
                            .listRowSeparator(.hidden)
                            .listRowInsets(.init(top: 10, leading: 10,
                                                 bottom: alert.id == VM.items.last?.id ? 10 : 0,
                                                 trailing: 10))
                            .listRowBackground(Color.clear)
                    }
                    .listStyle(.plain)
                    .background(Color.blue1.opacity(0.20))
                }
            }
            .onAppear { VM.requestMyAlerts() }
            .navigationDestination(for: MyAlertsRoute.self) { route in
                switch route {
                case let .detail(id):
                    DetailAlertMAView(alertID: id, path: $path)
                case .add:
                    CreateAlertView(path: $path)
                case let .edit(id):
                    EditAlertView(alertId: id, path: $path)
                case .choiseLocation:
                    ChoiseLocation(path: $path)
                }
            }
            .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
            .onChange(of: VM.isLoading) { _, newValue in loadingManager.isLoading = newValue }
        }
    }
    
    private func editAction(id: Int) {
        path.append(MyAlertsRoute.edit(id: id))
    }
    
    private func deleteAction(id: Int) {
        VM.requestDeleteAlert(id: id)
    }
}
