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
        let episodeIds = character.episodeContainer.filter({ $0.value == nil }).map { $0.key }
        guard !episodeIds.isEmpty else { return }
        
        networkManager.fetchEpisodes(endpoint: .getMultiple(episodeIds: episodeIds)) { [weak self] result in
            switch result {
            case .success(let fetchedEpisodes):
                let episodes = fetchedEpisodes.map { fetchedEpisode in
                    let episodeModel = EpisodeModel(episode: fetchedEpisode)
                    self?.character.episodeContainer.updateValue(episodeModel, forKey: fetchedEpisode.id)
                    return episodeModel
                }
                self?.episodes = episodes
            case .failure(let error):
                print("Failed to load episodes. \(error.localizedDescription)")
            }
        }
    }
}
