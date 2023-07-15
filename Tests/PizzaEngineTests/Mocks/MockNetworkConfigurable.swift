//
//  MockNetworkConfigurable.swift
//
//
//  Created by Abin Baby on 15.07.23.
//

import Foundation
@testable import PizzaEngine
import XCTest

// MARK: - MockEndpoint

private struct MockEndpoint: URLConfig {
    var url: URL
}

// MARK: - MockConfig

struct MockConfig: NetworkConfigurable {
    static let shared: MockConfig = .init()

    let testDrinksJSONFile: String = "test_drinks"
    let testIngredientsJSONFile: String = "test_ingredients"
    let testPizzasJSONFile: String = "test_pizzas"
    let checkOutResponseJSONFile: String = "test_checkoutResponse"

    func ingredients() -> URLConfig {
        guard let jsonURL = Bundle.module.url(forResource: testIngredientsJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(testIngredientsJSONFile).json' failed!")
            fatalError("Loading file '\(testIngredientsJSONFile).json' failed!")
        }
        return MockEndpoint(url: jsonURL)
    }

    func drinks() -> URLConfig {
        guard let jsonURL = Bundle.module.url(forResource: testDrinksJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(testDrinksJSONFile).json' failed!")
            fatalError("Loading file '\(testDrinksJSONFile).json' failed!")
        }
        return MockEndpoint(url: jsonURL)
    }

    func pizzas() -> URLConfig {
        guard let jsonURL = Bundle.module.url(forResource: testPizzasJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(testPizzasJSONFile).json' failed!")
            fatalError("Loading file '\(testPizzasJSONFile).json' failed!")
        }
        return MockEndpoint(url: jsonURL)
    }

    func checkOut() -> URLConfig {
        guard let jsonURL = Bundle.module.url(forResource: checkOutResponseJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(checkOutResponseJSONFile).json' failed!")
            fatalError("Loading file '\(checkOutResponseJSONFile).json' failed!")
        }
        return MockEndpoint(url: jsonURL)
    }
}
