//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

typealias ImageContainer = (url: URL, image: UIImage?)

class CharacterModel: Identifiable, ObservableObject {
    
    let id: Int
    var avatar: Avatar
    var info: Info
    var originContainer: OriginContainer
    var episodeContainers: [EpisodeContainer]
    
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
        self.avatar = Avatar(imageContainer: imageContainer, name: name, status: status)
        self.info = Info(species: species, type: type, gender: gender)
        self.originContainer = originContainer
        self.episodeContainers = episodes
    }
    
    convenience init(character: Character) {
        let originContainer: OriginContainer = {
            let url = URL(string: character.origin.url ?? "")
            return OriginContainer(url: url, location: nil)
        }()
        
        let imageContainer: ImageContainer? = {
            guard let url = URL(string: character.imageUrl) else { return nil }
            return (url, nil)
        }()
        
        let episodes: [EpisodeContainer] = character.episodeUrls.compactMap { stringUrl in
            guard let url = URL(string: stringUrl) else { return nil }
            return EpisodeContainer(url: url)
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

extension CharacterModel {
    class Avatar {
        var imageContainer: ImageContainer?
        let name: String
        let status: String
        
        init(imageContainer: ImageContainer? = nil, name: String, status: String) {
            self.imageContainer = imageContainer
            self.name = name
            self.status = status
        }
    }
    
    class Info {
        let species: String
        let type: String
        let gender: String
        
        init(species: String, type: String, gender: String) {
            self.species = species
            self.type = type
            self.gender = gender
        }
    }
    
    class OriginContainer {
        var url: URL?
        var location: Location?
        
        init(url: URL? = nil, location: Location? = nil) {
            self.url = url
            self.location = location
        }
    }

    class EpisodeContainer {
        var url: URL
        var episode: EpisodeModel?
        
        init(url: URL, episode: EpisodeModel? = nil) {
            self.url = url
            self.episode = episode
        }
    }
}
