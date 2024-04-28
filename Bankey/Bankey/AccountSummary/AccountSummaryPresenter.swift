//
//  AccountSummeryPresenter.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation

protocol AccountSummaryPresenterProtocol {
    func attach(_ view: AccountSummaryViewProtocol)
    func fetchAccountSummaryModels()
}

class AccountSummaryPresenter: AccountSummaryPresenterProtocol {
    weak private var view: AccountSummaryViewProtocol?

    func attach(_ view: AccountSummaryViewProtocol) {
        assert(self.view == nil, "Cannot attach view twice")
        self.view = view
    }

    func fetchAccountSummaryModels() {
        var accounts = [AccountSummaryModel]()

        // Sample data for demonstration
        let sampleData: [(AccountType, String, String, String, String)] = [
            (.Banking, "Savings Account", "Type", "1200", "80"),
            (.CreditCard, "Platinum Card", "Type", "3400", "50"),
            (.Investment, "Stock Portfolio", "Type", "50000", "25"),
            (.Banking, "Checking Account", "Type", "2500", "30"),
            (.CreditCard, "Gold Card", "Type", "1800", "90"),
            (.Investment, "Mutual Fund", "Type", "32000", "75"),
            (.Banking, "Emergency Fund", "Type", "8000", "40"),
            (.CreditCard, "Travel Card", "Type", "1500", "20"),
            (.Investment, "Real Estate", "Type", "120000", "10"),
            (.Banking, "Retirement Account", "Type", "100000", "0")
        ]

        // Generate AccountSummaryModel instances based on sample data
        // Simulates a network call response
        for data in sampleData {
            let accountSummary = AccountSummaryModel(accountType: data.0,
                                                     accountName: data.1,
                                                     balanceType: data.2,
                                                     balanceDolars: data.3,
                                                     balanceCents: data.4)
            accounts.append(accountSummary)
        }
//        self.view?.getAccounts(accounts: accounts)
          self.view?.accounts = accounts
    }
}
