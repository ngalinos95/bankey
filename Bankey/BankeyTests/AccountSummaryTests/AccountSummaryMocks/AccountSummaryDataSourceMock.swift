//
//  AccountSummaryDataSourceMock.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 28/4/24.
//

import Foundation
@testable import Bankey

enum MockError: Error {
    case genericError
}

class AccountSummaryDataSourceMock: AccountSummaryDataSourceProtocol {
    let mockFactory = MockResponseFactory()
    let error: MockError?

    init(error:MockError? = nil) {
        self.error = error
    }


    func fetchAccounts() async throws -> [Bankey.AccountSummaryModel] {
        if let error {
            throw error
        }
        let mockRepsonse: [AccountSummaryModel] = try mockFactory.mockRepsonseFromFile(
            forResource: "MockAccountsResponse",
            withExtension: "json"
        )
        return mockRepsonse
    }
}
