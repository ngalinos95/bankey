//
//  MockResponseFactory.swift
//  BankeyTests
//
//  Created by Nikos Galinos on 28/4/24.
//

import Foundation

enum MockFactory: Error {
    case mockError
}

class MockResponseFactory {
    // Create a Response Model from a local JSON response
    func mockRepsonseFromFile<T: Decodable>(forResource: String,
                                            withExtension: String) throws -> T {
        if let fileURL = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
                do {
                    // Read data from file
                    let jsonData = try Data(contentsOf: fileURL)
                    // Decode JSON data based on give
                    let accountSummaryJSON = try JSONDecoder().decode(T.self, from: jsonData)
                    return accountSummaryJSON
                } catch {
                    throw MockFactory.mockError
                }
            } else {
                throw MockFactory.mockError
            }
    }
    // Create a Response Model from a JSON string
    func mockResponseFromString<T: Decodable>(jsonString: String) throws -> T {
        do {
            // Convert JSON string to Data
            guard let jsonData = jsonString.data(using: .utf8) else {
                throw MockFactory.mockError
            }
            // Decode JSON data
            let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedObject
        } catch {
            throw MockFactory.mockError
        }
    }
}
