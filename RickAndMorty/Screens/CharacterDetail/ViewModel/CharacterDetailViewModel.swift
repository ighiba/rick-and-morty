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
    
    // MARK: - Properties
    
    private var character: CharacterModel
    
    @Published var characterAvatar: CharacterModel.Avatar
    @Published var characterInfo: CharacterModel.Info
    @Published var originContainer: CharacterModel.OriginContainer
    @Published var episodes: [EpisodeModel] = []
    
    var networkManager: NetworkManager!
    
    // MARK: - Init
    
    init(character: CharacterModel) {
        self.characterAvatar = character.avatar
        self.characterInfo = character.info
        self.originContainer = character.originContainer
        self.character = character
    }
    
    // MARK: - Methods
    
    func updateCharacterData() {
        updateOrigin()
        //updateEpisodes()
    }
    
    private func updateOrigin() {
        guard character.originContainer.location == nil else { return }
        let url = character.originContainer.url
        networkManager.fetchLocation(endpoint: .directUrl(url)) { [weak self] result in
            switch result {
            case .success(let fetchedLocation):
                self?.character.originContainer.location = fetchedLocation
                if let originContainer = self?.character.originContainer {
                    self?.originContainer = originContainer
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateEpisodes() {
        let group = DispatchGroup()
        
        character.episodes.filter({ $0.episode == nil }).enumerated().forEach { (index, episode) in
            group.enter()
            networkManager.fetchEpisode(endpoint: .directUrl(episode.url)) { result in
                switch result {
                case .success(let fetchedEpisode):
                    episode.episode = EpisodeModel(episode: fetchedEpisode)
                case .failure(let error):
                    print(error.localizedDescription)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            if let episodes = self?.character.episodes.compactMap({ $0.episode }) {
                self?.episodes = episodes
            }
        }
    }
}
