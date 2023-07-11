//
//  Pizzas.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - Pizzas
public struct Pizzas: Decodable {
    public let basePrice: Int
    public let pizzas: [Pizza]
}

// MARK: - Pizza
public struct Pizza: Decodable {
    public let ingredients: [Int]
    public let name: String
    public let imageURL: String?
}
