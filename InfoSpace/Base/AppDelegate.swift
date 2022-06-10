//
//  AppDelegate.swift
//  InfoSpace
//
//  Created by Gonzalo MR on 24/5/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Reachability
        NetworkManager.shared.startReachability()
        
        window = CustomNavigationController.instance.configure()
        
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Reachability
        NetworkManager.shared.startReachability()
        
        // Notifications
        NotificationCenter.default.post(name: .AppWillEnterForeground, object: nil)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Reachability
        NetworkManager.shared.stopReachability()
        
        // Notifications
        NotificationCenter.default.post(name: .AppDidEnterBackground, object: nil)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

