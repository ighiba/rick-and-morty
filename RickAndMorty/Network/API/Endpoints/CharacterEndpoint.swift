//
//  CharacterEndpoint.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

extension API {
    enum Character: Endpoint {
        case getCharacters(page: Int)
        
        var path: String {
            switch self {
            case .getCharacters(_):
                return "/character"
            }
        }
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .getCharacters(let page):
                return [URLQueryItem(name: "page", value: "\(page)")]
            }
        }
    }
}
