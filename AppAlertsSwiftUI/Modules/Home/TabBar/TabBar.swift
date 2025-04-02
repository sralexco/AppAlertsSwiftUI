//
//  TabBar.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 13/03/25.
//

import SwiftUI

struct TabBar: View {
    
    @StateObject var loadingManager = LoadingManager()
    
    let appearance: UITabBarAppearance = UITabBarAppearance()
    init() {
        UITabBar.appearance().barTintColor = .white
        UITabBar.appearance().backgroundColor = .white
    }
    
    var body: some View {
        ZStack {
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
        .loadingView()
        .environmentObject(loadingManager)
    }
}

/*
struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        Alerts()
    }
}
*/
