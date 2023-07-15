//
//  PEModelTests.swift
//
//
//  Created by Abin Baby on 15.07.23.
//

@testable import PizzaEngine
import XCTest

class PEModelTests: XCTestCase {
    func testCheckOutItemsEncoding() throws {
        let pizzas = [
            Pizza(
                ingredients: [1, 2],
                name: "Margherita",
                imageUrl: "https://doclerlabs.github.io/mobile-native-challenge/images/pizza_PNG44095.png"
            ),
            Pizza(
                ingredients: [1, 5, 6],
                name: "Ricci e Asparagi",
                imageUrl: "https://doclerlabs.github.io/mobile-native-challenge/images/pizza_PNG44066.png"
            )
        ]

        XCTAssertEqual(pizzas.count, 2)
    }
}
