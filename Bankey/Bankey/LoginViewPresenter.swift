//
//  LoginViewPresenter.swift
//  Bankey
//
//  Created by Nikos Galinos on 24/4/24.
//

import Foundation
protocol LoginViewPresenterProtocol {
    func attach(_ view: LoginViewProtocol)
    func loginButtonAction(userName: String?, password: String?)
}

enum AuthenticationError: Error {
    case emptyInput
    case wrongCredentials
}

extension AuthenticationError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .emptyInput:
            return NSLocalizedString("Empty Input", comment: "")
        case .wrongCredentials:
            return NSLocalizedString("Wrong Password", comment: "")
        }
    }
}

class LoginViewPresenter: LoginViewPresenterProtocol {


    weak private var view: LoginViewProtocol?

    func attach(_ view: LoginViewProtocol) {
        assert(self.view == nil, "Cannot attach view twice")
        self.view = view
    }

    func loginButtonAction(userName: String?, password: String?) {
        do {
            try credentialsValidation(userName, password)
            // enter here the code of handing the success state
            view?.handleErrorLabel(isVisible: false, withtext: "")
        } catch {
            // enter here the code of handing the failure state
            view?.handleErrorLabel(isVisible: true, withtext: error.localizedDescription )
        }

    }

    private func credentialsValidation(_ userName: String?, _ password: String?) throws {
        guard let userName, let password  else {
            throw AuthenticationError.emptyInput
        }
        if password.isEmpty || userName.isEmpty {
            throw AuthenticationError.emptyInput
        }
        if password != "test1234" {
            throw AuthenticationError.wrongCredentials
        }

    }
}
