//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

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
        imageUrl: URL?,
        originContainer: OriginContainer,
        episodes: [EpisodeContainer]
    ) {
        self.id = id
        self.avatar = Avatar(imageUrl: imageUrl, name: name, status: status)
        self.info = Info(species: species, type: type, gender: gender)
        self.originContainer = originContainer
        self.episodeContainers = episodes
    }
    
    convenience init(character: Character) {
        let imageUrl = URL(string: character.imageUrl)
        
        let originContainer: OriginContainer = {
            let url = URL(string: character.origin.url ?? "")
            return OriginContainer(url: url, location: nil)
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
            imageUrl: imageUrl,
            originContainer: originContainer,
            episodes: episodes
        )
    }
}

extension CharacterModel {
    class Avatar {
        var imageUrl: URL?
        let name: String
        let status: String
        
        init(imageUrl: URL?, image: UIImage? = nil, name: String, status: String) {
            self.imageUrl = imageUrl
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
