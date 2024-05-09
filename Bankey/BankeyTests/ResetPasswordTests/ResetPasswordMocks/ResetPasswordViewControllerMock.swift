//
//  ResetPasswordViewControllerMock.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 9/5/24.
//

import Foundation
import UIKit
@testable import Bankey

class ResetPasswordViewControllerMock: ResetPassworViewControllerProtocol {
    var secondTextField: Bankey.PasswordTextField = PasswordTextField(placeHolder: "test2")
    var passwordStatusView: Bankey.PasswordStatusView = PasswordStatusView()
    var firstTextField: Bankey.PasswordTextField = PasswordTextField(placeHolder: "test1")
    var resetButton: UIButton = UIButton()
}
