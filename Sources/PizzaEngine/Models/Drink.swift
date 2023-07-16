//
//  Drink.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - Drink
public struct Drink: Codable {
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
