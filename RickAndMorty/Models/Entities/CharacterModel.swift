//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

typealias EpisodeContainer = [Int : EpisodeModel?]

class CharacterModel: Identifiable, ObservableObject {
    
    let id: Int
    var avatar: Avatar
    var info: Info
    var originContainer: OriginContainer
    var episodeContainer: EpisodeContainer
    
    init(
        id: Int,
        name: String,
        status: String,
        species: String,
        type: String,
        gender: String,
        imageUrl: URL?,
        originContainer: OriginContainer,
        episodeContainer: EpisodeContainer
    ) {
        self.id = id
        self.avatar = Avatar(imageUrl: imageUrl, name: name, status: status)
        self.info = Info(species: species, type: type, gender: gender)
        self.originContainer = originContainer
        self.episodeContainer = episodeContainer
    }
    
    convenience init(character: Character) {
        let imageUrl = URL(string: character.imageUrl)
        
        let originContainer: OriginContainer = {
            let url = URL(string: character.origin.url ?? "")
            return OriginContainer(url: url, location: nil)
        }()
        
        let episodeIds: [Int] = character.episodeUrls.compactMap { stringUrl in
            guard let url = URL(string: stringUrl), let id = Int(url.lastPathComponent) else { return nil }
            return id
        }
        
        var episodeContainer = EpisodeContainer()
        episodeIds.forEach { episodeContainer.updateValue(nil, forKey: $0) }

        self.init(
            id: character.id,
            name: character.name,
            status: character.status,
            species: character.species,
            type: character.type,
            gender: character.gender,
            imageUrl: imageUrl,
            originContainer: originContainer,
            episodeContainer: episodeContainer
        )
    }
}

extension CharacterModel {
    class Avatar {
        var imageUrl: URL?
        let name: String
        let status: String
        
        init(imageUrl: URL?, name: String, status: String) {
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
}
