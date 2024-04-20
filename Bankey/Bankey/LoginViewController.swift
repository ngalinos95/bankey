//
//  ViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 10/4/24.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}

extension LoginViewController {
    private func setup() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func layout() {

        // Add LoginView
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])



    }
}

