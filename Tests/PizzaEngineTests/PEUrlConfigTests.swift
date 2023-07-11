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

    func testIngredientsURL() {
        let urlConfig = PEUrlConfig.shared.ingredients()
        XCTAssertEqual(
            urlConfig.url.absoluteString,
            "https://doclerlabs.github.io/mobile-native-challenge/ingredients.json"
        )
    }

    func testDrinksURL() {
        let urlConfig = PEUrlConfig.shared.drinks()
        XCTAssertEqual(
            urlConfig.url.absoluteString,
            "https://doclerlabs.github.io/mobile-native-challenge/drinks.json"
        )
    }

    func testPizzasURL() {
        let urlConfig = PEUrlConfig.shared.pizzas()
        XCTAssertEqual(
            urlConfig.url.absoluteString,
            "https://doclerlabs.github.io/mobile-native-challenge/pizzas.json"
        )
    }

}
