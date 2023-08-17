//
//  FetchError.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

enum FetchError: Error {
    case badUrl(endpoint: Endpoint)
    case networkError(statusCode: Int)
    case decode
    case unknown

     var errorDescription: String? {
        switch self {
        case .badUrl(let endpoint):
            return NSLocalizedString("Bad URL. Cannot obtain url from Endpoint \(endpoint)", comment: "")
        case .networkError(let statusCode):
            return NSLocalizedString("Network error occured with code: \(statusCode)", comment: "")
        case .decode:
            return NSLocalizedString("Failed to decode JSON data. Check 'init(from decoder: Decoder) throws'", comment: "")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "")
        }
    }
}
