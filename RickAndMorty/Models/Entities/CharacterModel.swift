//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

typealias ImageContainer = (url: URL, image: UIImage?)

struct OriginContainer {
    var url: URL?
    var name: String?
    var type: String?
}

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
    let originContainer: OriginContainer
    var imageContainer: ImageContainer?
    var episodes: [EpisodeContainer]
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        originContainer: OriginContainer,
        imageContainer: ImageContainer?,
        episodes: [EpisodeContainer]
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.originContainer = originContainer
        self.imageContainer = imageContainer
        self.episodes = episodes
    }
    
    convenience init(character: Character) {
        let originContainer: OriginContainer = {
            let url = URL(string: character.origin.url ?? "")
            return OriginContainer(url: url, name: character.origin.name)
        }()
        
        let imageContainer: ImageContainer? = {
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
            originContainer: originContainer,
            imageContainer: imageContainer,
            episodes: episodes
        )
    }
}
