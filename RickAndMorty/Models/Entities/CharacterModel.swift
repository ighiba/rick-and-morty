//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

struct CharacterModel: Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Origin
    let image: (URL, UIImage?)?
    let episodes: [(URL, EpisodeModel?)]
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        origin: Origin,
        image: (URL, UIImage?)?,
        episodes: [(URL, EpisodeModel?)]
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.image = image
        self.episodes = episodes
    }
    
    init(character: Character) {
        let image: (URL, UIImage?)? = {
            if let url = URL(string: character.imageUrl) {
                return (url, nil)
            } else {
                return nil
            }
        }()
        
        let episodes: [(URL, EpisodeModel?)] = character.episodeUrls.compactMap { stringUrl in
            if let url = URL(string: stringUrl) {
                return (url, nil)
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
