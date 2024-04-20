//
//  AppDelegate.swift
//  Bankey
//
//  Created by Nikos Galinos on 10/4/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainPage = LoginViewController()
        let nav = UINavigationController(rootViewController: mainPage)
        window?.backgroundColor = .systemBackground
        window?.makeKeyAndVisible()
        window?.rootViewController = nav
        return true
    }
}

