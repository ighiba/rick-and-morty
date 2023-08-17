//
//  CharacterResponse.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

struct ResponseInfo: Decodable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

final class CharacterResponse: Decodable {
    let info: ResponseInfo
    let results: [Character]
}
