//
//  ResetPasswordPresenter.swift
//  Bankey
//
//  Created by Nikos Galinos on 8/5/24.
//

import Foundation
import UIKit

protocol ResetPasswordPresenterProtocol {
    func attach(_ view: ResetPassworViewControllerProtocol)
    func statusValidation(_ text: String)
    func passwordValidation()
    func matcherValidation()

}
class ResetPasswordPresenter: ResetPasswordPresenterProtocol {

    weak private var view: ResetPassworViewControllerProtocol?
    // A dictionary to count the frequency
    var validPasswordConstraints = 0
    // A computed property to check for the password validation
    var isPasswordValid: Bool {
        return validPasswordConstraints >= 3
        && isLengthValid(passwordText)
    }
    // Extract the Password and Matchers text
    private var passwordText: String {
        return self.view?.firstTextField.passwordTextField.text ?? ""
    }
    private var matcherText: String {
        return self.view?.secondTextField.passwordTextField.text ?? ""
    }

    func attach(_ view: ResetPassworViewControllerProtocol) {
        assert(self.view == nil, "Cannot attach view twice")
        self.view = view
        view.firstTextField.passwordTextField.placeholder = "Enter New Password"
        view.secondTextField.passwordTextField.placeholder = "Re-Enter New Password"
    }
}

// MARK: - Validations
extension ResetPasswordPresenter {
    // Matcher Valifation
    func matcherValidation() {
        if view?.firstTextField.passwordTextField.text !=
            view?.secondTextField.passwordTextField.text {
            view?.secondTextField.errorLabel.isHidden = false
            view?.secondTextField.errorLabel.text = "Your password dont match"
            view?.resetButton.isEnabled = false
        } else {
            view?.secondTextField.errorLabel.isHidden = true
            view?.resetButton.isEnabled = true
        }
    }
    func passwordValidation(){
        if isPasswordValid {
            view?.firstTextField.errorLabel.isHidden = true
            view?.resetButton.isEnabled = true
        } else {
            view?.firstTextField.errorLabel.isHidden = false
            view?.resetButton.isEnabled = false
            view?.firstTextField.errorLabel.text = "Please check the validation criterias"
        }
    }
    // Status Validation
    func statusValidation(_ text: String) {
        validPasswordConstraints = 0
        view?.passwordStatusView.firstCriteriaLabel.isCriteriaMet = isLengthValid(text)
        view?.passwordStatusView.secondCriteriaLabel.isCriteriaMet = hasUpperCase(text)
        view?.passwordStatusView.thirdCriteriaLabel.isCriteriaMet = hasLowerCase(text)
        view?.passwordStatusView.forthCriteriaLabel.isCriteriaMet = hasNumber(text)
        view?.passwordStatusView.fifthCriteriaLabel.isCriteriaMet = hasSymbol(text)
    }
    // First Criteria Validation
    func isLengthValid(_ text: String) -> Bool{
        let validation = text.count > 8 && text.count < 32
        return validation
    }
    // Second Criteria Validation
    func hasUpperCase(_ text: String) -> Bool {
        let validation =  text.contains { $0.isLowercase }
        if validation { validPasswordConstraints += 1 }
        return validation
    }
    // Third Criteria Validation
    func hasLowerCase(_ text: String) -> Bool {
        let validation =  text.contains { $0.isLowercase }
        if validation { validPasswordConstraints += 1 }
        return validation
    }
    // Forth Criteria Validation
    func hasNumber(_ text: String) -> Bool {
        let validation =  text.contains { $0.isNumber }
        if validation { validPasswordConstraints += 1 }
        return validation
    }
    // Fifth CriteriaValidation
    func hasSymbol(_ text: String) -> Bool {
        let regex = #"[!@#$%&*]"#
        if let _ = text.range(of: regex, options: .regularExpression) {
            validPasswordConstraints += 1
            return true
        } else {
            return false
        }
    }
}

