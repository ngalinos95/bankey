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
    func updateStatusValidation(_ text: String)
    func passwordValidation()
    func matcherValidation()
    func resetView()

}
class ResetPasswordPresenter: ResetPasswordPresenterProtocol {

    weak private var view: ResetPassworViewControllerProtocol?
    // count the frequency of the valid constraints
    var validPasswordConstraints = 0
    // A computed property to check for the password validation
    var isPasswordValid: Bool {
        return validPasswordConstraints >= 3
        && isLengthValid(passwordText)
    }
    // A computed property to check for the matcher validation
    var isMatcherValid: Bool {
        passwordText == matcherText
    }
    // Extract text from Password Textfield
    private var passwordText: String {
        return self.view?.firstTextField.passwordTextField.text ?? ""
    }
    // Extract text from Matcher Textfield
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
// MARK: - Reset View
extension ResetPasswordPresenter {
    /**
     Reset view with :
     - empty trextfield
     - reseted validations
     - disabled reset button
     */
    func resetView() {
        view?.passwordStatusView.reset()
        view?.firstTextField.reset()
        view?.secondTextField.reset()
        view?.resetButton.isEnabled = false
    }
}


// MARK: - Validations
extension ResetPasswordPresenter {
    /**
     Check if the Reset button should be enabled or disabled
     Perform the appropriate Actions to the View
     */
    private func updateResetButtonStatus() {
        if isPasswordValid && isMatcherValid {
            self.view?.resetButton.isEnabled = true
        } else {
            self.view?.resetButton.isEnabled = false
        }
    }
    /**
     Check if the Matching password is Valid (is matching)
     Perform the appropriate Actions to the View
     */
    func matcherValidation() {
        if isMatcherValid {
            view?.secondTextField.errorLabel.isHidden = true
        } else {
            view?.secondTextField.errorLabel.isHidden = false
            view?.secondTextField.errorLabel.text = "Your password dont match"
        }
        updateResetButtonStatus()
    }
    /**
     Check if Password is Valid
     Perform the appropriate Actions to the View
     */
    func passwordValidation(){
        if isPasswordValid {
            view?.firstTextField.errorLabel.isHidden = true
        } else {
            view?.firstTextField.errorLabel.isHidden = false
            view?.firstTextField.errorLabel.text = "Please check the validation criterias"
        }
        updateResetButtonStatus()
    }

    /**
     Update the Password Status View according
     to the validation checks
     */
    func updateStatusValidation(_ text: String) {
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

