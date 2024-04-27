//
//  AppDelegate.swift
//  Bankey
//
//  Created by Nikos Galinos on 10/4/24.
//

import UIKit
let appColor: UIColor = .systemTeal
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Navigation Section
    let loginVC = LoginViewController()
    let onboardingVC = OnboardingContainerViewController()
    let mainVC = MainViewController()
    // Setup Delegate
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginVC.rootDelegate = self
        onboardingVC.rootDelegate = self
        registerForNotifcations()
        window?.rootViewController = loginVC
        return true
    }
}

// MARK: - Navigation
extension AppDelegate {
    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
}

extension AppDelegate: LoginViewRootProtocol {
    func didFinishLoginIn() {
        if LocalState.hasOnboarded {
            mainVC.selectedIndex = 0
            changeRootViewController(mainVC)
        } else {
            changeRootViewController(onboardingVC)
        }
    }
}

extension AppDelegate: OnboardingRootProtocol {
    func didSkipOnboarding() {
        LocalState.hasOnboarded = true
        changeRootViewController(mainVC)
    }
    func didCloseOnboarding() {
        changeRootViewController(loginVC)
    }
}

extension AppDelegate {
    @objc func didLogout() {
        changeRootViewController(loginVC)
    }
}

// MARK: - Notifications Center
extension AppDelegate {
    private func registerForNotifcations() {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
}

