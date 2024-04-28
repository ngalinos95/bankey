//
//  APIService.swift
//  Bankey
//
//  Created by Nikos Galinos on 26/4/24.
//

import Foundation
import SwiftUI
struct APIService {
    let urlString: String

    func getAPI<T: Decodable>(for: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw FetchError.urlError
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200
            else {
                throw FetchError.networkError
            }
            do {
                let decodedData =  try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw FetchError.decodingError
            }
        } catch {
            throw FetchError.dataTaskError
        }
    }
}


// Create custom Erros for out fetch API function
enum FetchError: Error, LocalizedError {
    case urlError
    case dataTaskError
    case networkError
    case decodingError

    var errorDescription: String? {
        switch self {
        case .urlError:
            return "The url you provided is invalid"
        case .networkError:
            return "Network Error"
        case .decodingError:
            return "Decoding Error, there was an error decoding data with the given model"
        case .dataTaskError:
            return "Data Task Error"
        }
    }
}
