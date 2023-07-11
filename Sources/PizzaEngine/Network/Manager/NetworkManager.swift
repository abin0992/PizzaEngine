//
//  NetworkManager.swift
//  
//
//  Created by Abin Baby on 10.07.23.
//

import Foundation

protocol NetworkSessionManager {
    typealias CompletionHandler = (Result<Data, PEError>) -> Void

    func fetchData(
        from request: URLRequest,
        completion: @escaping CompletionHandler
    )
}

protocol NetworkService {
    func request<T: Decodable>(
        endpoint: URL,
        completion: @escaping (Result<T, PEError>
    ) -> Void)
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
    func fetchData(
        from request: URLRequest,
        completion: @escaping (Result<Data, PEError>) -> Void
    ) {
        let sessionDataTask = URLSession.shared.dataTask(with: request) { data, response, requestError in
            if let requestError = requestError {
                var error: PEError
                if let response = response as? HTTPURLResponse {
                    error = .PEError(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }

                self.logger.log(error: error)
                completion(.failure(error))
            } else {

                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    self.logger.log(error: .networkError)
                    completion(.failure(.networkError))
                    return
                }

                guard let data = data else {
                    self.logger.log(error: .noData)
                    completion(.failure(.noData))
                    return
                }

                self.logger.log(responseData: data, response: response)
                completion(.success(data))
            }
        }
        sessionDataTask.resume()
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

    func request<T: Decodable>(
        endpoint: URL,
        completion: @escaping (Result<T, PEError>) -> Void
    ) {
        let urlRequest = URLRequest(url: endpoint)
        fetchData(from: urlRequest) { responseData in
            switch responseData {
            case .success(let responseData):
                do {
                    let result: T = try self.decoder.decode(T.self, from: responseData)
                    completion(.success(result))
                } catch {
                    self.logger.log(error: .invalidData)
                    completion(.failure(.invalidData))
                }
            case .failure(let error):
                self.logger.log(error: error)
                completion(.failure(error))
            }
        }
    }
}
