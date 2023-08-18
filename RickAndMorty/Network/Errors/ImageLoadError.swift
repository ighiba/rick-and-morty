//
//  ImageLoadError.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

enum ImageLoadError: Error {
    case unknown
    case networkError(statusCode: Int)
    case dataError
}
