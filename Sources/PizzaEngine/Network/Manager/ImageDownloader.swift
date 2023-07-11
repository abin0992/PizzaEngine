//
//  ImageDownloader.swift
//  
//
//  Created by Abin Baby on 10.07.23.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

class ImageDownloader {

    static let sharedInstance: ImageDownloader = ImageDownloader()
    private let networkManager: NetworkManager
    private let cache: NSCache<NSString, UIImage> = NSCache()
    private let logger: NetworkErrorLogger

    init(
        networkManager: NetworkManager = .sharedInstance,
        logger: NetworkErrorLogger = DefaultNetworkErrorLogger()
    ) {
        self.networkManager = networkManager
        self.logger = logger
    }

    func downloadImage(
        from urlString: String,
        completion: @escaping (Result<Any, Error>) -> Void
    ) {
        guard let url: URL = URL(string: urlString) else {
            self.logger.log(error: .urlGeneration)
            completion(.failure(PEError.urlGeneration))
            return
        }
        networkManager.fetchData(from: URLRequest(url: url)) { responseData in
            switch responseData {
            case .success(let responseData):
            #if canImport(UIKit)
                guard let image = UIImage(data: responseData) else {
                    completion(.failure(PEError.invalidData))
                    return
                }
            #elseif canImport(AppKit)
                guard let image = NSImage(data: responseData) else {
                    completion(.failure(PEError.invalidData))
                    return
                }
            #endif
                let cacheKey: NSString = NSString(string: urlString)
                self.cache.setObject(image, forKey: cacheKey)
                completion(.success(image))
            case .failure(let error):
                self.logger.log(error: error)
                completion(.failure(PEError.generic))
            }
        }
    }
}
