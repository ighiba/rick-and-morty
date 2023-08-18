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
    
    static let shared = CachedImageLoader()
    
    private var cachedImages = NSCache<NSString, UIImage>()
    
    private let session = URLSession.shared
    private let validCodes = 200...299
    
    private init() {}
    
    func load(url: URL, completion: @escaping (ImageLoadResult) -> Void) {
        if let cachedImage = cachedImages.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
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
                strongSelf.cachedImages.setObject(image, forKey:  url.absoluteString as NSString)
                result = .success(image)
            } else {
                result = .failure(.dataError)
            }
        }.resume()
    }
}
