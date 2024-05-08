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

}
class ResetPasswordPresenter: ResetPasswordPresenterProtocol {

    weak private var view: ResetPassworViewControllerProtocol?

    func attach(_ view: ResetPassworViewControllerProtocol) {
        assert(self.view == nil, "Cannot attach view twice")
        self.view = view
        view.firstTextField.passwordTextField.placeholder = "Enter New Password"
        view.secondTextField.passwordTextField.placeholder = "Re-Enter New Password"
    }
}

// MARK: - Validations
extension ResetPasswordPresenter {
    // Status Validation
    func statusValidation(_ text: String) {
        view?.passwordStatusView.firstCriteriaLabel.isCriteriaMet = isLengthValid(text)
        view?.passwordStatusView.secondCriteriaLabel.isCriteriaMet = hasUpperCase(text)
        view?.passwordStatusView.thirdCriteriaLabel.isCriteriaMet = hasLowerCase(text)
        view?.passwordStatusView.forthCriteriaLabel.isCriteriaMet = hasNumber(text)
        view?.passwordStatusView.fifthCriteriaLabel.isCriteriaMet = hasSymbol(text)
    }
    // First Criteria Validation
    func isLengthValid(_ text: String) -> Bool{
        return (text.count > 8 && text.count < 32)
    }
    // Second Criteria Validation
    func hasUpperCase(_ text: String) -> Bool {
        return text.contains { $0.isLowercase }
    }
    // Third Criteria Validation
    func hasLowerCase(_ text: String) -> Bool {
        return text.contains { $0.isLowercase }
    }
    // Forth Criteria Validation
    func hasNumber(_ text: String) -> Bool {
        return text.contains { $0.isNumber }
    }
    func hasSymbol(_ text: String) -> Bool {
        let regex = #"[!@#$%&*]"#
        if let _ = text.range(of: regex, options: .regularExpression) {
            return true
        } else {
            return false
        }
    }
}

