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
    /** If we wanted to be correct the assertion should have included the
     return uiModel from the fetchAccountSummaryModels function testing that the returned UImodel is the one expected
     that would be more reasonable on a real life example where the fetch functions calls an actual API and we should have provided
     a mock service with a mock response on return
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
        self.view = nil
        self.sut = nil
    }

    func fetchAccountSummaryModels() async {
        // Given
        sut.attach(view)
        //When
        await sut.fetchAccountSummaryModels()
        // Then
        XCTAssertEqual(view.actions, [.getAccounts])

    }


}
