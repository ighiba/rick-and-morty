//
//  ImageLoadError.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

enum ImageLoadError: Error, LocalizedError {
    case unknown
    case networkError(statusCode: Int)
    case dataError
    
    var errorDescription: String? { "ImageLoadError: \(getLocalizedDescription())" }
    
    private func getLocalizedDescription() -> String {
        switch self {
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        case .networkError(let statusCode):
            return NSLocalizedString("Network error occured with code: \(statusCode)", comment: "")
        case .dataError:
            return NSLocalizedString("Failed to decode data to UIImage.'", comment: "")
        }
    }
}
