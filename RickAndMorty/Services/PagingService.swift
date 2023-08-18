//
//  PagingService.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

protocol PagingService: AnyObject {
    var nextPageUrl: URL? { get set }
    var isNextAvailable: Bool { get }
}

final class PagingServiceImpl: PagingService {
    var nextPageUrl: URL?
    var isNextAvailable: Bool { nextPageUrl != nil }
    
    init(nextPageUrl: URL? = nil) {
        self.nextPageUrl = nextPageUrl
    }
}
