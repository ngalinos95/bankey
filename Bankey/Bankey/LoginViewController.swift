//
//  ViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 10/4/24.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func handleErrorLabel(isVisible: Bool, withtext text: String)
}

class LoginViewController: UIViewController, LoginViewProtocol {

    private let presenter: LoginViewPresenterProtocol
    private var userName: String? {
        return loginView.userNameTextField.text
    }
    private var password: String? {
        return loginView.paswordTextField.text
    }

    init(presenter: LoginViewPresenterProtocol = LoginViewPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter.attach(self)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    // LoginView
    let loginView = LoginView()
    // LoginButton
    lazy var loginButton: UIButton = {
        let loginButton = UIButton(type: .system)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.configuration = .filled()
        loginButton.configuration?.imagePadding = 8
        loginButton.setTitle("Sign In", for: [])
        return loginButton
    }()
    // Error Label
    lazy var errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = true
        return errorLabel
    }()
}

extension LoginViewController {
    private func setup() {
        // Setup LoginView
        loginView.translatesAutoresizingMaskIntoConstraints = false
        // Setup LoginButton
        loginButton.setTitle("Sign In", for: [])
        loginButton.addTarget(self,
                              action: #selector(signInTapped),
                              for: .primaryActionTriggered)
        // Setup Error Label
        errorLabel.text = " The input you have entered in invalid"
    }

    private func layout() {
        // Add LoginView
        view.addSubview(loginView)
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: 8),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                constant: -8)
        ])
        // Add LoginButton
        view.addSubview(loginButton)
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: loginView.bottomAnchor,
                                             constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor)
        ])
        //Add Error Label
        view.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor,
                                            constant: 16),
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

// MARK: Actions
extension LoginViewController {
    @objc func signInTapped(sender: UIButton) {
        // Add button  function
        presenter.loginButtonAction(userName: self.userName,
                                    password: self.password )
    }

    func handleErrorLabel(isVisible: Bool, withtext text: String) {
        if isVisible {
            errorLabel.isHidden = false
            errorLabel.text = text
        } else {
            errorLabel.isHidden = true
        }
    }
}

