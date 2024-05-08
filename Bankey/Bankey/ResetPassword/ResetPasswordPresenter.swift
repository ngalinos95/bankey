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
