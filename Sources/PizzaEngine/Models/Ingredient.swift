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
}
