//
//  App199App.swift
//  App199
//
//  Created by Вячеслав on 9/28/23.
//

import SwiftUI
import FirebaseCore
import ApphudSDK
import Amplitude

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Apphud.start(apiKey: "app_KxvKBFRJ9c5tjnamp8N5vaTrQxSTib")
        Amplitude.instance().initializeApiKey("1f531f3500f08900511f2c3f8b32331b")

        FirebaseApp.configure()
        
        return true
    }
}

@main
struct App199App: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        
        WindowGroup {
            
            NavigationView(content: {
                
                ContentView()
            })
        }
    }
}
