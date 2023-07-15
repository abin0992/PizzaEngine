//
//  CheckOutItems.swift
//  
//
//  Created by Abin Baby on 15.07.23.
//

import Foundation

public struct CheckOutItems: Encodable {
    public let pizzas: [Pizza]
    public let drinks: [String]

    public init(
        pizzas: [Pizza],
        drinks: [String]
    ) {
        self.pizzas = pizzas
        self.drinks = drinks
    }
}

