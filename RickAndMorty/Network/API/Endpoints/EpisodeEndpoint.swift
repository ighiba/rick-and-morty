//
//  EpisodeEndpoint.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

extension API {
    enum Episode: Endpoint {
        case get(episodeId: Int)
        case directUrl(URL?)
        
        var path: String {
            switch self {
            case .get(let episodeId):
                return "/api/episode/\(episodeId)"
            case .directUrl(_):
                return ""
            }
        }
        
        var queryItems: [URLQueryItem] { [] }
        
        var url: URL? {
            switch self {
            case .get(_):
                return defaultUrl()
            case .directUrl(let url):
                return url
            }
        }
    }
}
