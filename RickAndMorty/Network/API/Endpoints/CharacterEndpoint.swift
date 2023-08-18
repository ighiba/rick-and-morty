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
        case directUrl(URL?)
        
        var path: String {
            switch self {
            case .getCharacters(_):
                return "/character"
            case .directUrl(_):
                return ""
            }
        }
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .getCharacters(let page):
                return [URLQueryItem(name: "page", value: "\(page)")]
            case .directUrl(_):
                return []
            }
        }
        
        var url: URL? {
            switch self {
            case .getCharacters(_):
                return defaultUrl()
            case .directUrl(let url):
                return url
            }
        }
    }
}
