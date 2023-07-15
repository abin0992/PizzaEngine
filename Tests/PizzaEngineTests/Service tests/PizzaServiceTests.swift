//
//  PizzaServiceTests.swift
//
//
//  Created by Abin Baby on 15.07.23.
//

import Foundation
@testable import PizzaEngine
import XCTest

class PizzaServiceTests: XCTestCase {
    var mockPizzaService: PizzaService!
    var mockNetworkService: MockNetworkManager!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkManager.shared
        mockPizzaService = PizzaService(
            networkManager: mockNetworkService,
            config: MockConfig.shared
        )
    }

    override func tearDown() {
        mockPizzaService = nil
        super.tearDown()
    }
    
    func testFetchPizzas_SuccessfulResponse_ReturnsPizzasInfo() async {
        // Prepare
        let expectedPizzasInfo = PizzasInfo(
            basePrice: 4.0,
            pizzas: [
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
        )
        
        // Execute
        do {
            let result = try await mockPizzaService.fetchPizzas()
            
            // Verify
            XCTAssertEqual(result.pizzas.count, expectedPizzasInfo.pizzas.count)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    // TODO: unit tests for fetchIngredients and fetchDrinks methods
}
