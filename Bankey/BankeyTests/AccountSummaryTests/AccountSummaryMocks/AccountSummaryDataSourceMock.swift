//
//  AccountSummaryDataSourceMock.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 28/4/24.
//

import Foundation
@testable import Bankey

class AccountSummaryDataSourceMock: AccountSummaryDataSourceProtocol {
    let mockFactory = MockResponseFactory()

    func fetchAccounts() async throws -> [Bankey.AccountSummaryModel] {
        let mockRepsonse: [AccountSummaryModel] = try mockFactory.mockRepsonseFromFile(
            forResource: "MockAccountsResponse",
            withExtension: "json"
        )
        return mockRepsonse
    }
}
