//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

typealias ImageLoadResult = Result<UIImage, ImageLoadError>

protocol ImageLoader: AnyObject {
    func load(url: URL) async -> ImageLoadResult
}

final class CachedImageLoader: ImageLoader {
    
    struct Config {
        let countLimit: Int
        var totalCostLimit: Int { 1024 * 1024 * countLimit }
        
        static let defaultConfig = Config(countLimit: 100) // 100 mb
    }
    
    static let shared = CachedImageLoader()
    
    private var cachedImages: NSCache<AnyObject, AnyObject> = {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.totalCostLimit = Config.defaultConfig.totalCostLimit
        return cache
    }()
    
    private let imageProcessingQueue = DispatchQueue(label: "ru.ighiba.imageProcessing", qos: .utility)

    private let session = URLSession.shared
    private let validCodes = 200...299

    private init() {}
    
    func cachedImage(forUrl url: URL) -> UIImage? {
        return cachedImages.object(forKey: url as AnyObject) as? UIImage
    }
    
    func load(url: URL) async -> ImageLoadResult {
        if let cachedImage = cachedImage(forUrl: url) {
            return .success(cachedImage)
        }
        
        guard let (data, response) = try? await session.data(from: url) as? (Data, HTTPURLResponse) else {
            return .failure(.unknown)
        }
        
        guard validCodes.contains(response.statusCode) else {
            return .failure(.networkError(statusCode: response.statusCode))
        }
        
        guard let image = UIImage(data: data) else {
            return .failure(.dataError)
        }
        
        let processedImage = await processImage(image)
        cachedImages.setObject(processedImage, forKey: url as AnyObject)
        
        return .success(processedImage)
    }

    private func processImage(_ image: UIImage) async -> UIImage {
        var processedImage = image
        
        if let compressedImage = processedImage.compressed(.high) {
            processedImage = compressedImage.resized(to: .avatarImageSize)
        }
        
        return processedImage
    }
}
