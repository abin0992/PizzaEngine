//
//  PizzaService.swift
//  
//
//  Created by Abin Baby on 11.07.23.
//

import Foundation
import UIKit

protocol PizzaServiceProtocol {
    func fetchPizzas(completion: @escaping (Result<Pizzas, PEError>) -> Void)
    func fetchIngredients(completion: @escaping (Result<[Ingredient], PEError>) -> Void)
    func fetchDrinks(completion: @escaping (Result<[Drink], PEError>) -> Void)
    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void)
}

class PizzaService: PizzaServiceProtocol {

    public typealias RetrievePizzasResult = ((Result<Pizzas, PEError>) -> Void)
    public typealias RetrieveIngredientsResult = ((Result<[Ingredient], PEError>) -> Void)
    public typealias RetrieveDrinksResult = ((Result<[Drink], PEError>) -> Void)
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

    func fetchPizzas(
        completion: @escaping RetrievePizzasResult
    ) {
        networkManager.request(
            endpoint: config.pizzas().url
        ) { (result: Result<Pizzas, PEError>) in
            switch result {
            case .success(let pizzas):
                completion(.success(pizzas))
            case .failure(let exception):
                completion(.failure(exception))
            }
        }
    }
    
    func fetchIngredients(
        completion: @escaping RetrieveIngredientsResult
    ) {
        networkManager.request(
            endpoint: config.ingredients().url
        ) { (result: Result<[Ingredient], PEError>) in
            switch result {
            case .success(let dataArray):
                completion(.success(dataArray))
            case .failure(let exception):
                completion(.failure(exception))
            }
        }
    }
    
    func fetchDrinks(
        completion: @escaping RetrieveDrinksResult
    ) {
        networkManager.request(
            endpoint: config.drinks().url
        ) { (result: Result<[Drink], PEError>) in
            switch result {
            case .success(let dataArray):
                completion(.success(dataArray))
            case .failure(let exception):
                completion(.failure(exception))
            }
        }
    }
    
    func downloadImage(
        from urlString: String,
        completion: @escaping FetchImageCompletion
    ) {
        imageDownloader.downloadImage(from: urlString) { result in
            if
                case .success(let image) = result,
                let uiImage = image as? UIImage
            {
                completion(uiImage)
            } else {
                completion(nil)
            }
        }
    }
}
