//
//  AppDelegate.swift
//  AppAlertsSwiftUI
//
//  Created by alex on 22/03/25.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GMSServices.provideAPIKey("AIzaSyD8w8CXX5bHvk2LJ_qN8dm2dp0E0gPPj1g")
        GMSPlacesClient.provideAPIKey("AIzaSyD8w8CXX5bHvk2LJ_qN8dm2dp0E0gPPj1g")
        return true
    }
}
