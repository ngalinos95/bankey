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

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    // Create the User Name Text Field
    lazy var userNameTextField: UITextField = {
        let userNameTextField = UITextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.placeholder = "User Name"
        userNameTextField.delegate = self
        return userNameTextField
    }()


}

extension LoginView {
    private func setup() {
        // SetUp UIView
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .orange
        // Setup userNameTextField

    }

    private func layout() {
        // Add userNameTextField
        self.addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: self.topAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            userNameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
    }
}

// MARK: - UITextField Delegate
extension LoginView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.endEditing(true)
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
