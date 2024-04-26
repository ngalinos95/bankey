//
//  AppDelegate.swift
//  Bankey
//
//  Created by Nikos Galinos on 10/4/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // Navigation Section
    let loginVC = LoginViewController()
    let onboardingVC = OnboardingContainerViewController()
    let dummyVC = DummyViewController()
    // Setup Delegate
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        let mainPage = OnboardingContainerViewController()
//        let nav = UINavigationController(rootViewController: mainPage)
        window?.backgroundColor = .systemBackground
        loginVC.rootDelegate = self
        onboardingVC.rootDelegate = self
        dummyVC.logoutDelegate = self
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
            changeRootViewController(dummyVC)
        } else {
            changeRootViewController(onboardingVC)
        }
    }
}

extension AppDelegate: OnboardingRootProtocol {
    func didSkipOnboarding() {
        LocalState.hasOnboarded = true
        changeRootViewController(dummyVC)
    }
    func didCloseOnboarding() {
        changeRootViewController(loginVC)
    }
}

extension AppDelegate: LogoutDelegate {
    func didLogout() {
        changeRootViewController(loginVC)
    }
}
