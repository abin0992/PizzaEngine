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
}

// MARK: - Pizza
public struct Pizza: Codable {
    public let ingredients: [Int]
    public let name: String
    public let imageUrl: String?
}
