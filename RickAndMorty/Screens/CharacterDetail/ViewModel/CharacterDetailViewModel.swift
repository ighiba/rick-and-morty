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
    
    init(character: CharacterModel, networkManager: NetworkManager) {
        self.characterAvatar = character.avatar
        self.characterInfo = character.info
        self.originContainer = character.originContainer
        self.character = character
        self.networkManager = networkManager
        updateCharacterData()
    }
    
    // MARK: - Methods
    
    func updateCharacterData() {
        updateOrigin()
        updateEpisodes()
    }
    
    private func updateOrigin() {
        guard character.originContainer.location == nil else { return }
        let url = character.originContainer.url
        networkManager.fetchLocation(endpoint: .directUrl(url)) { [weak self] result in
            switch result {
            case .success(let fetchedLocation):
                self?.character.originContainer.location = fetchedLocation
                guard let originContainer = self?.character.originContainer else { return }
                self?.originContainer = originContainer
            case .failure(let error):
                print("Failed to load origin. \(error.localizedDescription)")
            }
        }
    }
    
    private func updateEpisodes() {
        let group = DispatchGroup()
        
        character.episodeContainers.filter({ $0.episode == nil }).forEach { episode in
            group.enter()
            networkManager.fetchEpisode(endpoint: .directUrl(episode.url)) { result in
                switch result {
                case .success(let fetchedEpisode):
                    episode.episode = EpisodeModel(episode: fetchedEpisode)
                case .failure(let error):
                    print("Failed to load episode. \(error.localizedDescription)")
                }
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            guard let episodes = self?.character.episodeContainers.compactMap({ $0.episode }) else { return }
            self?.episodes = episodes
        }
    }
}
