//
//  Ingredient.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - Ingredient
public struct Ingredient: Decodable {
    public let price: Double
    public let name: String
    public let id: Int

    public init(
        price: Double,
        name: String,
        id: Int
    ) {
        self.price = price
        self.name = name
        self.id = id
    }
}

extension Ingredient: Comparable {
    public static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return lhs.name < rhs.name
    }
}
