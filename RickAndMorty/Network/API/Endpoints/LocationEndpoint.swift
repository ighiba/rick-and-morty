//
//  LocationEndpoint.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

extension API {
    enum Location: Endpoint {
        case get(locationId: Int)
        case directUrl(URL?)
        
        var path: String {
            switch self {
            case .get(let locationId):
                return "/api/location/\(locationId)"
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
