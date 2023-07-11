//
//  PEEndPoints.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

protocol URLConfig {
    var url: URL { get }
}

private struct PEEndPoint: URLConfig {

    let path: String
    var queryItems: [URLQueryItem] = []
    var url: URL {
        var components: URLComponents = URLComponents()
        components.scheme = "https"
        components.host = AppConfiguration.apiBaseURL
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

protocol NetworkConfigurable {
    func ingredients() -> URLConfig
    func drinks() -> URLConfig
    func pizzas() -> URLConfig
}

struct PEUrlConfig: NetworkConfigurable {

    static let shared: PEUrlConfig = PEUrlConfig()

    private struct Paths {
        static let ingredients = "/mobile-native-challenge/ingredients.json"
        static let drinks = "/mobile-native-challenge/drinks.json"
        static let pizzas = "/mobile-native-challenge/pizzas.json"
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
}
