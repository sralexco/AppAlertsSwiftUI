//
//  MapView.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 24/03/25.
//
import SwiftUI

enum MapRoute: Hashable {
    case detail(id: Int)
}

struct MapView: View {
    @StateObject var VM = MapViewModel()
    @State private var path = [MapRoute]()
    
    var body: some View {
        
        NavigationStack(path: $path) {
            //CustomNavView(title: "Map", icon: "person.circle") {
            
            ZStack {
                VStack(alignment: .center) {
                    if VM.locationManager.authorizationStatus != .authorizedAlways &&
                        VM.locationManager.authorizationStatus != .authorizedWhenInUse {
                        AlertInfoView(text: "You need to to allow location in configuration")
                    }
                     /* if VM.isEmpty {
                     AlertInfoView(text: "No alerts yet")
                     } */
                    
                    if VM.isLocationEnabled {
                        GoogleMapsView(alerts: VM.items, callback: self.showDetail)
                            .padding(.top, 56)
                    }
                    
                    Spacer(minLength: 0)
                }
                .onAppear {
                    VM.getAuthorizationLocation()
                    if VM.isLocationEnabled {
                        VM.requestGetAlerts()
                    }
                }
                AlertDetail(path: $path, hideDetail: $VM.hideDetail, alertSelected: $VM.alertSelected)
                    .zIndex(1)
                    .opacity(VM.hideDetail ? 0 : 1)
            }
            .navigationDestination(for: MapRoute.self) { route in
                switch route {
                case let .detail(id):
                    DetailAlertMView(alertID: id, path: $path)
                }}
        }
    }
    
    func showDetail(index: Int) {
        let item = VM.items[index]
        VM.alertSelected = item
        VM.hideDetail = false
    }
    
}

struct AlertDetail: View {
    @Binding var path: [MapRoute]
    @Binding var hideDetail: Bool
    @Binding var alertSelected: AlertMModel?
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Image("ic_alert")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .padding([.leading, .trailing], 14)
                VStack(alignment: .leading, spacing: 0) {
                    Text(alertSelected?.title ?? "")
                        .padding(.top, 16)
                        .padding(.leading, -2)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black1)
                    Text(alertSelected?.description ?? "")
                        .padding(.top, 4)
                        .padding(.leading, -2)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black1)
                    Spacer(minLength: 0)
                }
                Spacer(minLength: 0)
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 50, height: 50)
                        .zIndex(2)
                        .contentShape(Rectangle())
                        .onTapGesture { hideDetail = true }
                    Image("ic_close")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .padding(.trailing, 16)
                        .padding(.top, -18)
                }
            }
            .background(.white)
            .frame(height: 80)
            .onTapGesture { path.append(MapRoute.detail(id: alertSelected?.id ?? 0)) }
        }
    }
}
