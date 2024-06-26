//
//  MainViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
import UIKit
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }

    private func setupViews() {
        let summaryVC = AccountSummaryViewController()
        let moneyVC = MoveMoneyViewController()
        let moreVC = ResetPasswordViewController()

        summaryVC.setTabBarImage(imageName: "list.dash.header.rectangle", title: "Summary", tag: 0)
        moneyVC.setTabBarImage(imageName: "arrow.left.arrow.right", title: "Move Money", tag: 1)
        moreVC.setTabBarImage(imageName: "ellipsis.circle", title: "More", tag: 2)

        let summaryNC = UINavigationController(rootViewController: summaryVC)
        let moneyNC = UINavigationController(rootViewController: moneyVC)
        let moreNC = UINavigationController(rootViewController: moreVC)
        summaryNC.setStatusBar()

        let tabBarList = [summaryNC, moneyNC, moreNC]

        self.viewControllers = tabBarList
    }

    private func setupTabBar() {
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = appColor
    }
}


class MoveMoneyViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
    }
}

class MoreViewController: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .systemPurple
    }
}
