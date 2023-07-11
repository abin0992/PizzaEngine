//
//  Ingredient.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - Ingredient
public struct Ingredient: Decodable {
    let price: Double
    let name: String
    let id: Int
}
