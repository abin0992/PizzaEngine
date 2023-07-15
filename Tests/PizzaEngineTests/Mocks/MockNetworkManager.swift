//
//  MockNetworkManager.swift
//
//
//  Created by Abin Baby on 15.07.23.
//

import Foundation
@testable import PizzaEngine
import XCTest

// MARK: - MockNetworkManager

class MockNetworkManager: NetworkService {
    static let shared: MockNetworkManager = .init()

    func request<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let responseData = try await fetchData(from: urlRequest)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601

        do {
            let result: T = try decoder.decode(T.self, from: responseData)
            return result
        } catch {
            XCTFail("Reading contents of file json failed! (Exception: \(error))")
            throw PEError.invalidData
        }
    }
}

// MARK: NetworkSessionManager

extension MockNetworkManager: NetworkSessionManager {
    func fetchData(from request: URLRequest) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
