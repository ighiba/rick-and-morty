//
//  Location.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

struct Location: Identifiable, Decodable {
    let id: Int
    let name: String
    let type: String
}
