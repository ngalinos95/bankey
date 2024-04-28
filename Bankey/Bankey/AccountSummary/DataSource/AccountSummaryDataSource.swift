//
//  AccountSummaryDataSource.swift
//  Bankey
//
//  Created by Nikos Galinos on 28/4/24.
//

import Foundation
protocol AccountSummaryDataSourceProtocol {
    func fetchAccounts() async throws -> [AccountSummaryModel]
}
class AccountSummaryDataSource: AccountSummaryDataSourceProtocol {
    let service: APIServiceProtocol

    init(service: APIServiceProtocol = APIService()) {
        self.service = service
    }

    func fetchAccounts() async throws -> [AccountSummaryModel]  {
        let url = "https://api.jsonserve.com/pdc6mR"
        let accounts = try await service.getAPI(for: [AccountSummaryModel].self,
                                                urlString: url)
        return accounts
    }
}
