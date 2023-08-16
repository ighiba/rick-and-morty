//
//  Character.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

struct Character: Identifiable, Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let image: String
    let episode: [String]
}
