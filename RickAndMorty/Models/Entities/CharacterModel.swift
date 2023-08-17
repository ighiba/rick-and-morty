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
    var episodes: [EpisodeContainerModel]
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        originContainer: OriginContainer,
        imageContainer: ImageContainer?,
        episodes: [EpisodeContainerModel]
    ) {
        self.id = id
        self.avatar = Avatar(imageContainer: imageContainer, name: name, status: status)
        self.info = Info(species: species, type: type, gender: gender)
        self.originContainer = originContainer
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
        
        let episodes: [EpisodeContainerModel] = character.episodeUrls.enumerated().compactMap { (index, stringUrl) in
            if let url = URL(string: stringUrl) {
                return EpisodeContainerModel(id: index, url: url)
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
        var name: String?
        var type: String?
        
        init(url: URL? = nil, name: String? = nil, type: String? = nil) {
            self.url = url
            self.name = name
            self.type = type
        }
    }

    class EpisodeContainerModel: Identifiable {
        var id: Int
        var url: URL
        var episode: EpisodeModel?
        
        init(id: Int, url: URL, episode: EpisodeModel? = nil) {
            self.id = id
            self.url = url
            self.episode = episode
        }
    }
}
