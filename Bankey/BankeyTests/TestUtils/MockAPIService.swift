//
//  MockAPIService.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 28/4/24.
//

import Foundation
@testable import Bankey

class MockAPIService: APIServiceProtocol {
    var mockReponse: Any
    var error: MockError?
    init(mockResponse: Any, error: MockError? = nil) {
        self.mockReponse = mockResponse
        self.error = error
    }

    func getAPI<T: Decodable>(for: T.Type, urlString: String) async throws -> T {
        if let error {
            throw error
        }
        return mockReponse as! T
    }
}
