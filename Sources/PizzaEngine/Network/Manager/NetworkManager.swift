//
//  NetworkManager.swift
//
//
//  Created by Abin Baby on 10.07.23.
//

import Foundation

// MARK: - NetworkSessionManager

protocol NetworkSessionManager {
    func fetchData(from request: URLRequest) async throws -> Data
}

// MARK: - NetworkService

protocol NetworkService {
    func request<T: Decodable>(urlRequest: URLRequest) async throws -> T
}

// MARK: - NetworkManager

class NetworkManager: NetworkSessionManager {
    static let sharedInstance: NetworkManager = .init()
    private let logger: NetworkErrorLogger

    init(
        logger: NetworkErrorLogger = DefaultNetworkErrorLogger()
    ) {
        self.logger = logger
    }

    internal
    func fetchData(from request: URLRequest) async throws -> Data {
        logger.log(request: request)
        let (responseData, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            logger.log(error: .networkError)
            throw PEError.networkError
        }
        guard 200 ... 299 ~= httpResponse.statusCode else {
            let error = PEError.PEError(statusCode: httpResponse.statusCode)
            logger.log(error: error)
            throw error
        }
        logger.log(responseData: responseData, response: httpResponse)
        return responseData
    }
}

// MARK: NetworkService

extension NetworkManager: NetworkService {
    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func request<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let responseData = try await fetchData(from: urlRequest)

        // TODO: Add reachability to check internet connection and return corresponding error
        do {
            let result: T = try decoder.decode(T.self, from: responseData)
            return result
        } catch {
            logger.log(error: .invalidData)
            throw PEError.invalidData
        }
    }
}
