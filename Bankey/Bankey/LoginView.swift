//
//  LoginView.swift
//  Bankey
//
//  Created by Nikos Galinos on 20/4/24.
//

import Foundation
import UIKit

class LoginView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    // This is required for storyboards and we dont need it
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override var intrinsicContentSize: CGSize {
//        return CGSize(width: 200, height: 200)
//    }
    // MARK: Create UI Views
    // Create A Stack View
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    // Create User Name Text Field
    lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User Name"
        userNameTextField.delegate = self
//        userNameTextField.borderStyle = .bezel
        return userNameTextField
    }()
    // Create Password Text Field
    lazy var paswordTextField: UITextField = {
        let paswordTextField = UITextField()
        paswordTextField.translatesAutoresizingMaskIntoConstraints = false
        paswordTextField.placeholder = "Password"
        paswordTextField.delegate = self
//        paswordTextField.borderStyle = .bezel
        paswordTextField.isSecureTextEntry = true
        return paswordTextField
    }()

    // Create Divider View
    lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .secondarySystemFill
        return dividerView
    }()


}

extension LoginView {
    private func setup() {
        // SetUp UIView
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 5
        self.clipsToBounds = true

    }

    private func layout() {
        // Add stackView
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -8),
            dividerView.heightAnchor.constraint(equalToConstant: 1)
        ])

        // Add userNameTextField to stackView
        stackView.addArrangedSubview(userNameTextField)
        // Add dividerView
        stackView.addArrangedSubview(dividerView)
        // Add paswordTextField to stackView
        stackView.addArrangedSubview(paswordTextField)
    }
}

// MARK: - UITextField Delegate
extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.endEditing(true)
        paswordTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
    }

}
