//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

typealias ImageLoadResult = Result<UIImage, ImageLoadError>

protocol ImageLoader: AnyObject {
    func load(url: URL, completion: @escaping (ImageLoadResult) -> Void)
}

class CachedImageLoader: ImageLoader {
    
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
    
    func load(url: URL, completion: @escaping (ImageLoadResult) -> Void) {
        if let cachedImage = cachedImage(forUrl: url) {
            completion(.success(cachedImage))
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in
            var result: ImageLoadResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let strongSelf = self else {
                result = .failure(.unknown)
                return
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                result = .failure(.unknown)
                return
            }
            
            guard strongSelf.validCodes.contains(httpUrlResponse.statusCode) else {
                result = .failure(.networkError(statusCode: httpUrlResponse.statusCode))
                return
            }
            
            if error == nil, let data  {
                guard let image = UIImage(data: data) else {
                    result = .failure(.dataError)
                    return
                }
                result = .success(image)
                strongSelf.processImage(image, onQueue: strongSelf.imageProcessingQueue) { processedImage in
                    self?.cachedImages.setObject(processedImage, forKey: url as AnyObject)
                    result = .success(processedImage)
                    return
                }
            } else {
                result = .failure(.dataError)
            }
        }.resume()
    }
    
    private func processImage(_ image: UIImage, onQueue queue: DispatchQueue, completion: @escaping (UIImage) -> Void) {
        queue.async {
            var processedImage = image
            if let compressedImage = processedImage.compressed(.high) {
                processedImage = compressedImage.resized(to: .avatarImageSize)
            }
            completion(processedImage)
        }
    }
}
