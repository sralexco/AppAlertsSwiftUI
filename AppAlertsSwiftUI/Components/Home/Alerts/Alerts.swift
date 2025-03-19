//
//  Alerts.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import SwiftUI

enum Route: Hashable {
    case detail(id:Int)
    case add
    case choiseLocation
}

struct Alerts: View {
    @StateObject var VM = AlertsViewModel()
    @State private var path = [Route]()
    var title = "Alerts"
    @StateObject var locationManager = LocationManager()
    init(){ UIScrollView.appearance().bounces = false }
    
    
    var body: some View {
        Text("sds")
    }
}

#Preview {
    Alerts()
}



