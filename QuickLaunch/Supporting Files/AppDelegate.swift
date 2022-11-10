//
//  AppDelegate.swift
//  QuickLaunch
//
//  Created by Pasha Otverchenko on 09.11.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = configureNavgiationVC()
        
        return true
    }
}

//MARK: - Private Helpers -

extension AppDelegate {
    private func configureNavgiationVC() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: ChatListViewController())
        navVC.navigationBar.backgroundColor = .systemBlue        
        return navVC
    }
}
