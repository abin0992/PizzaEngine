//
//  PizzaService.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation
import UIKit

protocol PizzaServiceProtocol {
    func fetchPizzas() async throws -> PizzasInfo
    func fetchIngredients() async throws -> [Ingredient]
    func fetchDrinks() async throws -> [Drink]
    func downloadImage(from urlString: String) async throws -> UIImage?
}

public class PizzaService: PizzaServiceProtocol {

    public typealias FetchImageCompletion = ((UIImage?) -> Void)

    private let networkManager: NetworkService
    private let config: NetworkConfigurable
    private let imageDownloader: ImageDownloader

    init(
        networkManager: NetworkService = NetworkManager.sharedInstance,
        config: NetworkConfigurable = PEUrlConfig.shared,
        imageDownloader: ImageDownloader = ImageDownloader.sharedInstance
    ) {
        self.networkManager = networkManager
        self.config = config
        self.imageDownloader = imageDownloader
    }

    public init() {
        self.networkManager = NetworkManager.sharedInstance
        self.config = PEUrlConfig.shared
        self.imageDownloader = ImageDownloader.sharedInstance
    }

    public func fetchPizzas() async throws -> PizzasInfo {
        let pizzasInfo: PizzasInfo = try await networkManager.request(
            endpoint: config.pizzas().url
        )
        return pizzasInfo
    }
    
    public func fetchIngredients() async throws -> [Ingredient] {
        let ingredients: [Ingredient] = try await networkManager.request(
            endpoint: config.ingredients().url
        )
        return ingredients
    }
    
    public func fetchDrinks() async throws -> [Drink] {
        let drinks: [Drink] = try await networkManager.request(
            endpoint: config.drinks().url
        )
        return drinks
    }
    
    public func downloadImage(from urlString: String) async throws -> UIImage? {
        do {
            let image: Any = try await imageDownloader.downloadImage(from: urlString)
            if let uiImage = image as? UIImage {
                return uiImage
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
