//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject {
    func updateCharacterData()
}

class CharacterDetailViewModel: CharacterDetailViewModelDelegate, ObservableObject {
    
    private var character: CharacterModel
    
    @Published var characterAvatar: CharacterModel.Avatar
    @Published var characterInfo: CharacterModel.Info
    @Published var originContainer: CharacterModel.OriginContainer
    @Published var episodes: [EpisodeModel] = []
    
    var characterDidChangeHandler: ((CharacterModel) -> Void)?
    
    var networkManager: NetworkManager!
    
    init(character: CharacterModel) {
        self.characterAvatar = character.avatar
        self.characterInfo = character.info
        self.originContainer = character.originContainer
        self.character = character
    }
    
    func updateCharacterData() {
        //updateEpisodes()
    }
    
    private func updateEpisodes() {
        let group = DispatchGroup()
        
        character.episodes.filter({ $0.episode == nil }).enumerated().forEach { (index, episode) in
            group.enter()
            networkManager.fetchEpisode(endpoint: .directUrl(episode.url)) { result in
                switch result {
                case .success(let success):
                    episode.episode = EpisodeModel(episode: success)
                case .failure(let failure):
                    print(failure)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.episodes = self.character.episodes.compactMap { $0.episode }
        }
    }
}
