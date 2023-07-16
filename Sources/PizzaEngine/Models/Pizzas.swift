//
//  Pizzas.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - Pizzas
public struct PizzasInfo: Codable {
    public let basePrice: Double
    public let pizzas: [Pizza]
    
    public init(
        basePrice: Double,
        pizzas: [Pizza]
    ) {
        self.basePrice = basePrice
        self.pizzas = pizzas
    }
}

// MARK: - Pizza
public struct Pizza: Codable {
    public let ingredients: [Int]
    public let name: String
    public let imageUrl: String?
    
    public init(
        ingredients: [Int],
        name: String,
        imageUrl: String?
    ) {
        self.ingredients = ingredients
        self.name = name
        self.imageUrl = imageUrl
    }

}
