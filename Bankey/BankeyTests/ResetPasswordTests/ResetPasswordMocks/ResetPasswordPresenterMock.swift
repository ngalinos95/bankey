//
//  ResetPasswordPresenterMock.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 9/5/24.
//

import Foundation
@testable import Bankey

class ResetPasswordPresenterMock: ResetPasswordPresenterProtocol {

    var actions: [Actions] = []

    enum Actions: Equatable {
        case attach
        case updateStatusValidation(String)
        case passwordValidation
        case matcherValidation
        case resetView
    }

    func attach(_ view: any Bankey.ResetPassworViewControllerProtocol) {
        actions.append(.attach)
    }
    
    func updateStatusValidation(_ text: String) {
        actions.append(.updateStatusValidation(text))
    }
    
    func passwordValidation() {
        actions.append(.passwordValidation)
    }
    
    func matcherValidation() {
        actions.append(.matcherValidation)
    }
    
    func resetView() {
        actions.append(.resetView)
    }
}
