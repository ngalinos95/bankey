//
//  AccountSummaryViewControllerMock.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
@testable import Bankey

class AccountSummaryViewControllerMock: AccountSummaryViewProtocol {
    enum Actions: Equatable {
        case getAccounts
        case showLoader
        case hideLoader
    }

    var actions: [Actions] = []

    func showLoader() {
        actions += [.showLoader]

    }
    
    func hideLoader() {
        actions += [.hideLoader]

    }
    



    func getAccounts(accounts: [Bankey.AccountSummaryModel]) {
        actions += [.getAccounts]
    }
}
