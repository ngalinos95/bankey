//
//  ResetPasswordViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 8/5/24.
//

import Foundation
import UIKit

protocol ResetPassworViewControllerProtocol: AnyObject {

}

class ResetPasswordViewController: UIViewController, ResetPassworViewControllerProtocol {

    let presenter: ResetPasswordPresenterProtocol

    init(presenter: ResetPasswordPresenterProtocol = ResetPasswordPresenter() ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        self.presenter.attach(self)
        super.viewDidLoad()
        setup()
        layout()
    }

// MARK: - Views
    let firstTextField =  PasswordTextField()

}

// MARK: - Setup
extension ResetPasswordViewController {

    func setup() {
        firstTextField.passwordTextField.placeholder = "Enter password"
    }

    func layout() {
        // Add first textfield
        view.addSubview(firstTextField)
        NSLayoutConstraint.activate([
            firstTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
    }

}

// MARK: - Delegates Conformance
extension ResetPasswordViewController {

}

// MARK: - Actions







