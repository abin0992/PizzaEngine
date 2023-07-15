//
//  PizzaService.swift
//
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - PizzaServiceProtocol

protocol PizzaServiceProtocol {
    func fetchPizzas() async throws -> PizzasInfo
    func fetchIngredients() async throws -> [Ingredient]
    func fetchDrinks() async throws -> [Drink]
}

// MARK: - PizzaService

public class PizzaService: PizzaServiceProtocol {
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

    public func fetchPizzas() async throws -> PizzasInfo {
        let urlRequest = URLRequest(url: config.pizzas().url)
        let pizzasInfo: PizzasInfo = try await networkManager.request(
            urlRequest: urlRequest
        )
        return pizzasInfo
    }

    public func fetchIngredients() async throws -> [Ingredient] {
        let urlRequest = URLRequest(url: config.ingredients().url)
        let ingredients: [Ingredient] = try await networkManager.request(
            urlRequest: urlRequest
        )
        return ingredients
    }

    public func fetchDrinks() async throws -> [Drink] {
        let urlRequest = URLRequest(url: config.drinks().url)
        let drinks: [Drink] = try await networkManager.request(
            urlRequest: urlRequest
        )
        return drinks
    }
}
