//
//  CheckOutService.swift
//  
//
//  Created by Abin Baby on 15.07.23.
//

import Foundation

protocol CheckOutServiceProtocol {
    func checkOut(items: CheckOutItems) async throws -> CheckoutResponse
}

public class CheckOutService: CheckOutServiceProtocol {

    private let networkManager: NetworkService
    private let config: NetworkConfigurable

    init(
        networkManager: NetworkService = NetworkManager.sharedInstance,
        config: NetworkConfigurable = PEUrlConfig.shared
    ) {
        self.networkManager = networkManager
        self.config = config
    }

    public init() {
        self.networkManager = NetworkManager.sharedInstance
        self.config = PEUrlConfig.shared
    }

    public func checkOut(items: CheckOutItems) async throws -> CheckoutResponse {
        let encoder = JSONEncoder()
        let requestData = try encoder.encode(items)

        var request = URLRequest(url: config.checkOut().url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = requestData
        
        return try await networkManager.request(urlRequest: request)
    
    }
}
