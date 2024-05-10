//
//  AccountSummaryDataSourceTests.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 28/4/24.
//

import XCTest
@testable import Bankey

final class AccountSummaryDataSourceTests: XCTestCase {

    var sut: AccountSummaryDataSource!
    var mockService: MockAPIService!
    let mockFactory = MockResponseFactory()
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        self.mockService = nil
        self.sut = nil
    }

    func testDataSourceFetchAccount() async throws {
        // Given
        let mockRepsonse: [AccountSummaryModel] = try mockFactory.mockRepsonseFromFile(
            forResource: "MockAccountsResponse",
            withExtension: ".json"
        )
        self.mockService = MockAPIService(mockResponse: mockRepsonse)
        self.sut = AccountSummaryDataSource(service: mockService)
        //When
        let response = try await sut.fetchAccounts()
        // Then
        XCTAssertEqual(response.count, 4)
        XCTAssertEqual(response.first?.accountName, "Checking")
    }

    func testDataSourceFetchAccountWithError() async throws {
        // Given
        let mockRepsonse: [AccountSummaryModel] = try mockFactory.mockRepsonseFromFile(
            forResource: "MockAccountsResponse",
            withExtension: ".json"
        )
        self.mockService = MockAPIService(mockResponse: mockRepsonse,error: .genericError)
        self.sut = AccountSummaryDataSource(service: mockService)
        //When
        do {
            let response = try await sut.fetchAccounts()
            XCTFail("It should throw error and continue on the catch block")
        } catch {
            //When
            XCTAssertEqual(error as! MockError, MockError.genericError)
        }
    }

}
