//
//  NetworkManager.swift
//  
//
//  Created by Abin Baby on 10.07.23.
//

import Foundation

protocol NetworkSessionManager {
    func fetchData(from request: URLRequest) async throws -> Data
}

protocol NetworkService {
    func request<T: Decodable>(urlRequest: URLRequest) async throws -> T
}

class NetworkManager: NetworkSessionManager {

    static let sharedInstance: NetworkManager = NetworkManager()
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
        guard 200...299 ~= httpResponse.statusCode else {
            let error = PEError.PEError(statusCode: httpResponse.statusCode)
            logger.log(error: error)
            throw error
        }
        logger.log(responseData: responseData, response: httpResponse)
        return responseData
    }

    private func resolve(error: Error) -> PEError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        default: return .generic
        }
    }
}

extension NetworkManager: NetworkService {

    var decoder: JSONDecoder {
        let decoder: JSONDecoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }

    func request<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        let responseData = try await fetchData(from: urlRequest)
        
        do {
            let result: T = try decoder.decode(T.self, from: responseData)
            return result
        } catch {
            logger.log(error: .invalidData)
            throw PEError.invalidData
        }
    }
}
