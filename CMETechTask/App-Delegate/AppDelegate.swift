//
//  AppDelegate.swift
//  CMETechTask
//
//  Created by mohamed ahmed on 30/01/2025.
//

import UIKit

@UIApplicationMain
class CMEAppDelegate: UIResponder, UIApplicationDelegate {
    private var mainCompositeRoor: RouteSessionCachable = MainCompositeRoot()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        mainCompositeRoor
            .coordinator
            .getInitialScreen(
                .countryListView(
                    mainSession: mainCompositeRoor
                )
            )
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCompositeRoor.coordinator.router
        window?.makeKeyAndVisible()
        return true
    }
}
