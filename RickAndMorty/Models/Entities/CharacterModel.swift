//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

typealias ImageContainer = (url: URL, image: UIImage?)

struct EpisodeContainer: Identifiable {
    var id: Int
    var url: URL
    var episode: EpisodeModel?
}

class CharacterModel: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    var imageContainer: ImageContainer?
    var episodes: [EpisodeContainer]
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: Origin,
        image: ImageContainer?,
        episodes: [EpisodeContainer]
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.imageContainer = image
        self.episodes = episodes
    }
    
    convenience init(character: Character) {
        let image: ImageContainer? = {
            if let url = URL(string: character.imageUrl) {
                return (url, nil)
            } else {
                return nil
            }
        }()
        
        let episodes: [EpisodeContainer] = character.episodeUrls.enumerated().compactMap { (index, stringUrl) in
            if let url = URL(string: stringUrl) {
                return EpisodeContainer(id: index, url: url)
            } else {
                return nil
            }
        }

        self.init(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            origin: character.origin,
            image: image,
            episodes: episodes
        )
    }
}
