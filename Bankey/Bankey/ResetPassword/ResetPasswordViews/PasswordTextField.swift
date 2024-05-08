//
//  PasswordTextField.swift
//  Bankey
//
//  Created by Nikos Galinos on 8/5/24.
//

import Foundation
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func textFieldChanged(_ text: String)
}

class PasswordTextField: UIView {
    let placeHolder: String
    weak var passwordDelegate: PasswordTextFieldDelegate?
    weak var matcherDelegate: PasswordTextFieldDelegate?

    init(placeHolder: String) {
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        setup()
        layout()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 60)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - Views
    // Password TextField
    lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Password"
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = false
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.addTarget(self, action: #selector(textFieldDIdEditingChanged), for: .editingChanged)
        return passwordTextField
    }()
    // Left Textfield Image
    lazy var lockImage: UIImageView = {
        let lockImage = UIImageView()
        lockImage.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "lock.fill")
        lockImage.image = image
        lockImage.tintColor = .systemBlue
        return lockImage
    }()
    // Right Textfield Button
    lazy var visibilityButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        button.addTarget(self, action: #selector(didTapVisibility), for: .touchUpInside)
        return button
    }()
    // Divider
    lazy var divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = .secondarySystemBackground
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    // Error label
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "The password you have entered is false false false  false false false"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .systemRed
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    // StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
}

// MARK: - Setup
extension PasswordTextField {

    func setup() {
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leftView = lockImage
        passwordTextField.leftViewMode = .always
        passwordTextField.rightView = visibilityButton
        passwordTextField.rightViewMode = .always

    }

    func layout() {
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
        // Add ArrangedSubViews
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(divider)
        stackView.addArrangedSubview(errorLabel)
    }
}
// MARK: - Action
extension PasswordTextField {
    @objc func didTapVisibility() {
        passwordTextField.isSecureTextEntry.toggle()
        visibilityButton.isSelected.toggle()
    }
}

// MARK: - Delegates
extension PasswordTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended editing")
    }
}
// MARK: - Actions
extension PasswordTextField {
    @objc func textFieldDIdEditingChanged(_ sender: UITextField) {
        self.passwordDelegate?.textFieldChanged(sender.text ?? "")
    }
}
