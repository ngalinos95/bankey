//
//  AccountSummaryPresenterTests.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 27/4/24.
//

import XCTest
@testable import Bankey

final class AccountSummaryPresenterTests: XCTestCase {
    // This is an example on how we can test a presenter
    /**  The actual  model that is given to the view is given from the datsource
         and the correctness of the model will be tested on the dataSource tests
     */

    var sut: AccountSummaryPresenter!
    var view: AccountSummaryViewControllerMock!
    var mockDataSource: AccountSummaryDataSourceMock!

    override func setUpWithError() throws {
        self.mockDataSource = AccountSummaryDataSourceMock()
        self.view = AccountSummaryViewControllerMock()
        self.sut = AccountSummaryPresenter(dataSource: mockDataSource)
    }

    override func tearDownWithError() throws {
        self.mockDataSource = nil
        self.view = nil
        self.sut = nil
    }

    func testFetchAccountSummaryModels() async {
        // Given
        sut.attach(view)
        //When
        await sut.fetchAccountSummaryModels()
        // Then
        XCTAssertEqual(view.actions, [.showLoader, .getAccounts, .hideLoader])

    }

    func testFetchAccountSummaryModelsWithError() async {
        // Given
        // Create a mockDataSource that throws an error
        self.mockDataSource = AccountSummaryDataSourceMock(error: .genericError)
        self.sut = AccountSummaryPresenter(dataSource: mockDataSource)
        sut.attach(view)
        //When
        await sut.fetchAccountSummaryModels()
        // Then
        XCTAssertEqual(view.actions, [.showLoader, .hideLoader])

    }


}
