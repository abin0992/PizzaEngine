//
//  PEUrlConfigTests.swift
//
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation
@testable import PizzaEngine
import XCTest

class PEUrlConfigTests: XCTestCase {
    func test_IngredientsURL() {
        let urlConfig = PEUrlConfig.shared.ingredients()
        XCTAssertEqual(
            urlConfig.url.absoluteString,
            "https://doclerlabs.github.io/mobile-native-challenge/ingredients.json"
        )
    }

    func test_DrinksURL() {
        let urlConfig = PEUrlConfig.shared.drinks()
        XCTAssertEqual(
            urlConfig.url.absoluteString,
            "https://doclerlabs.github.io/mobile-native-challenge/drinks.json"
        )
    }

    func test_PizzasURL() {
        let urlConfig = PEUrlConfig.shared.pizzas()
        XCTAssertEqual(
            urlConfig.url.absoluteString,
            "https://doclerlabs.github.io/mobile-native-challenge/pizzas.json"
        )
    }
}
