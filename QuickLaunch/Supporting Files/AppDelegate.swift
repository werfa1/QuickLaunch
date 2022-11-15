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
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = configureTabBarVC()
        
        return true
    }
}

//MARK: - Private Helpers -

extension AppDelegate {
    
    private func configureFeedVC() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: FeedViewController())
        let navBar = navVC.navigationBar
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemBlue
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navVC.tabBarItem.image = UIImage(systemName: "newspaper")
        navVC.tabBarItem.title = "Feed"
        return navVC
    }
    
    private func configureChatListVC() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: ChatListViewController())
        let navBar = navVC.navigationBar
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemBlue
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navVC.tabBarItem.image = UIImage(systemName: "message")
        navVC.tabBarItem.title = "Chats"
        return navVC
    }
    
    private func configureSettingsVC() -> UINavigationController {
        let navVC = UINavigationController(rootViewController: SettingsViewController())
        let navBar = navVC.navigationBar
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = .systemBlue
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navVC.tabBarItem.image = UIImage(systemName: "gear")
        navVC.tabBarItem.title = "Settings"
        return navVC
    }
    
    private func configureTabBarVC() -> UITabBarController {
        
        let tabBarVC = UITabBarController()
        tabBarVC.viewControllers = [configureFeedVC(), configureChatListVC(), configureSettingsVC()]
        UITabBar().standardAppearance.backgroundColor = .systemBackground
        tabBarVC.tabBar.backgroundColor = .systemGray6
        tabBarVC.tabBar.tintColor = .label
        return tabBarVC
    }
}


