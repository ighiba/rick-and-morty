//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

protocol Endpoint {
    var baseUrl: URL { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    var url: URL? { get }
}

extension Endpoint {
    var baseUrl: URL { URL(string: "https://rickandmortyapi.com")! }
    
    var url: URL? { defaultUrl() }
    
    func defaultUrl() -> URL? {
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        components.path = "/api" + path
        components.queryItems = queryItems
        return components.url
    }
}
