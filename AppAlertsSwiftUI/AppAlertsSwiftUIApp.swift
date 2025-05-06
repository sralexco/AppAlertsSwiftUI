//
//  AppAlertsSwiftUIApp.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 7/03/25.
//

import SwiftUI

@main
struct AppAlertsSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            //TabBar()
            MainView()
        }
    }
}
