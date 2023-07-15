//
//  PEEndPoints.swift
//
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - HTTPMethod

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

// MARK: - URLConfig

protocol URLConfig {
    var url: URL { get }
}

// MARK: - PEEndPoint

private struct PEEndPoint: URLConfig {
    var isCheckOutUrl: Bool = false
    let path: String
    var queryItems: [URLQueryItem] = []
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = isCheckOutUrl ? AppConfiguration.apiCheckOutURL : AppConfiguration.apiBaseURL
        components.path = path

        if queryItems.isEmpty {
            components.queryItems = nil
        } else {
            components.queryItems = queryItems
        }

        guard let url = components.url else {
            DLog("Invalid URL components: \(components)")
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }

        return url
    }
}

// MARK: - NetworkConfigurable

protocol NetworkConfigurable {
    func ingredients() -> URLConfig
    func drinks() -> URLConfig
    func pizzas() -> URLConfig
    func checkOut() -> URLConfig
}

// MARK: - PEUrlConfig

struct PEUrlConfig: NetworkConfigurable {
    static let shared: PEUrlConfig = .init()

    private enum Paths {
        static let ingredients = "/mobile-native-challenge/ingredients.json"
        static let drinks = "/mobile-native-challenge/drinks.json"
        static let pizzas = "/mobile-native-challenge/pizzas.json"
        static let checkout = "/post"
    }

    func ingredients() -> URLConfig {
        PEEndPoint(
            path: Paths.ingredients
        )
    }

    func drinks() -> URLConfig {
        PEEndPoint(
            path: Paths.drinks
        )
    }

    func pizzas() -> URLConfig {
        PEEndPoint(
            path: Paths.pizzas
        )
    }

    func checkOut() -> URLConfig {
        var endPoint = PEEndPoint(path: Paths.checkout)
        endPoint.isCheckOutUrl = true
        return endPoint
    }
}
