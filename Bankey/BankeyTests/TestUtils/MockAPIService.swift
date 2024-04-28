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
    init(mockResponse: Any) {
        self.mockReponse = mockResponse
    }

    func getAPI<T: Decodable>(for: T.Type, urlString: String) async throws -> T{
        return mockReponse as! T
    }
}
