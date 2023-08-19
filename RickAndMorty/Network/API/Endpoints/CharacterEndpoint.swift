//
//  CharacterEndpoint.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

extension API {
    enum Character: Endpoint {
        case getSingle(page: Int)
        case directUrl(URL?)
        
        var path: String {
            switch self {
            case .getSingle(_):
                return "/character"
            case .directUrl(_):
                return ""
            }
        }
        
        var queryItems: [URLQueryItem] {
            switch self {
            case .getSingle(let page):
                return [URLQueryItem(name: "page", value: "\(page)")]
            case .directUrl(_):
                return []
            }
        }
        
        var url: URL? {
            switch self {
            case .getSingle(_):
                return defaultUrl()
            case .directUrl(let url):
                return url
            }
        }
    }
}
