//
//  ResetPasswordViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 8/5/24.
//

import Foundation
import UIKit


protocol ResetPassworViewControllerProtocol: AnyObject {
    var firstTextField: PasswordTextField { get }
    var secondTextField: PasswordTextField { get }
    var passwordStatusView: PasswordStatusView { get }
    var resetButton: UIButton { get }
}

class ResetPasswordViewController: UIViewController, ResetPassworViewControllerProtocol {

    let presenter: ResetPasswordPresenterProtocol

    init(presenter: ResetPasswordPresenterProtocol = ResetPasswordPresenter()) {
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
    // Password TextField
    let firstTextField =  PasswordTextField(placeHolder: "Enter password")
    // Password Status
    let passwordStatusView = PasswordStatusView()
    // Re-enter Password TextField
    let secondTextField =  PasswordTextField(placeHolder: "Re-Enter password")
    // Reset Button
    lazy var resetButton: UIButton = {
        let resetButton = UIButton(type: .system)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.configuration = .filled()
        resetButton.setTitle("Reset password", for: [])
        resetButton.isEnabled = false
        // resetButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
        return resetButton
    }()



}

// MARK: - Setup
extension ResetPasswordViewController {

    func setup() {
        firstTextField.passwordDelegate = self
        secondTextField.matcherDelegate = self
        setupDismissKeyboardGesture()
    }

    func layout() {
        // Add first textfield
        view.addSubview(firstTextField)
        NSLayoutConstraint.activate([
            firstTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            firstTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            firstTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
        // Add Password Satus View
        view.addSubview(passwordStatusView)
        NSLayoutConstraint.activate([
            passwordStatusView.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: 16),
            passwordStatusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordStatusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
        // Add Second Password TextField (Re-Enter Password)
        view.addSubview(secondTextField)
        NSLayoutConstraint.activate([
            secondTextField.topAnchor.constraint(equalTo: passwordStatusView.bottomAnchor, constant: 16),
            secondTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            secondTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
        // Add Reset Button
        view.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: 16),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

}

// MARK: - Delegates Conformance
// We use this delegate to pass the text from textField View to the viewController
extension ResetPasswordViewController: PasswordTextFieldDelegate {
    func passwordTextFileldEndedEditing() {
        self.presenter.passwordValidation()
    }
    
    func matcherTextFileldEndedEditing() {
        self.presenter.matcherValidation()

    }
    
    func textFieldChanged(_ text: String) {
        self.presenter.statusValidation(text)
    }
}

// MARK: - Actions
extension ResetPasswordViewController {

    private func setupDismissKeyboardGesture() {
        let dismissKeyboatdTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_: )))
        view.addGestureRecognizer(dismissKeyboatdTap)
    }

    @objc func viewTapped(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}







