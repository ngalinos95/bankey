//
//  AccountSummaryViewControllerMock.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
@testable import Bankey

class AccountSummaryViewControllerMock: AccountSummaryViewProtocol {
    var actions: [Actions] = []

    enum Actions: Equatable {
        case getAccounts
    }

    func getAccounts(accounts: [Bankey.AccountSummaryModel]) {
        actions += [.getAccounts]
    }
}
