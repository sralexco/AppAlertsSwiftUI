//
//  TabBar.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import SwiftUI

struct TabBar: View {
    
    let appearance: UITabBarAppearance = UITabBarAppearance()
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        TabView {
            AlertsView()
                .tabItem {
                    Label("Alerts", systemImage: "list.bullet")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
            MyAlertsView()
                .tabItem {
                    Label("My Alerts", systemImage: "tray.full.fill")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

/*
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Alerts()
    }
}
*/
