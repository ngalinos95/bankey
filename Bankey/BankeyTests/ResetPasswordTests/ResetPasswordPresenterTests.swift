//
//  ResetPasswordPresenterTests.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 9/5/24.
//

import XCTest
@testable import Bankey

final class ResetPasswordPresenterTests: XCTestCase {

    var view: ResetPasswordViewControllerMock!
    var sut: ResetPasswordPresenter!

    override func setUpWithError() throws {
        view = ResetPasswordViewControllerMock()
        sut = ResetPasswordPresenter()
    }

    override func tearDownWithError() throws {
        view = nil
        sut = nil
    }

    func testAttachView() throws {
        // When
        sut.attach(view)
        // Then
        XCTAssertEqual(view.firstTextField.passwordTextField.placeholder, "Enter New Password")
        XCTAssertEqual(view.secondTextField.passwordTextField.placeholder, "Re-Enter New Password")
    }

    func testResetView() throws {
        // When
        sut.attach(view)
        sut.resetView()
        // Then
        XCTAssertEqual(view.passwordStatusView.firstCriteriaLabel.statusImage.image, view.passwordStatusView.firstCriteriaLabel.circleImage )
        XCTAssertEqual(view.firstTextField.passwordTextField.text, "")
        XCTAssertEqual(view.secondTextField.passwordTextField.text, "")
        XCTAssertEqual(view.resetButton.isEnabled, false)
    }

}
