//
//  EpisodeEndpoint.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

extension API {
    enum Episode: Endpoint {
        case getSingle(episodeId: Int)
        case getMultiple(episodeIds: [Int])
        case directUrl(URL?)
        
        var path: String {
            switch self {
            case .getSingle(let episodeId):
                return "/episode/\(episodeId)"
            case .getMultiple(let episodeIds):
                let stringIds = episodeIds.map(String.init).joined(separator: ",")
                return "/episode/\(stringIds)"
            case .directUrl(_):
                return ""
            }
        }
        
        var queryItems: [URLQueryItem] { [] }
        
        var url: URL? {
            switch self {
            case .getSingle(_), .getMultiple(_):
                return defaultUrl()
            case .directUrl(let url):
                return url
            }
        }
    }
}
