//
//  AppLovinTestbedApp.swift
//  AppLovinTestbed
//
//  This class stores global variables that are required for the configuration
//

import SwiftUI

@main
struct AppLovinTestbedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct MyVariables {
    static var onLoad = false
    static var idfa = "XXX"
    static var sendAdditionalData = false;
    static var userConsent = false;
}
