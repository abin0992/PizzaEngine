//
//  Pizzas.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation

// MARK: - Pizzas
struct Pizzas: Decodable {
    let basePrice: Int
    let pizzas: [Pizza]
}

// MARK: - Pizza
struct Pizza: Decodable {
    let ingredients: [Int]
    let name: String
    let imageURL: String?
}
