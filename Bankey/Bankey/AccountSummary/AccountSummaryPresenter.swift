//
//  AccountSummeryPresenter.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation

protocol AccountSummaryPresenterProtocol {
    func attach(_ view: AccountSummaryViewProtocol)
    func fetchAccountSummaryModels() async
}

class AccountSummaryPresenter: AccountSummaryPresenterProtocol {
    weak private var view: AccountSummaryViewProtocol?
    let dataSource: AccountSummaryDataSourceProtocol

    init(dataSource: AccountSummaryDataSourceProtocol = AccountSummaryDataSource()) {
        self.dataSource = dataSource
    }

    func attach(_ view: AccountSummaryViewProtocol) {
        assert(self.view == nil, "Cannot attach view twice")
        self.view = view
    }
    
    @MainActor
    func fetchAccountSummaryModels() async {
        view?.showLoader()
        do {
            let accounts = try await dataSource.fetchAccounts()
            self.view?.getAccounts(accounts: accounts)

        } catch {
            // TODO: Error Handling code should go here (call view error)
            print(error.localizedDescription)
        }
        view?.hideLoader()
    }
}
