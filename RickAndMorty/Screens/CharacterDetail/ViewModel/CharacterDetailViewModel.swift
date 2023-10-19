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
        self.character = character
        self.characterAvatar = character.avatar
        self.characterInfo = character.info
        self.originContainer = character.originContainer
        self.episodes = obtainEpisodesFromContainer()
        self.networkManager = networkManager
        updateCharacterData()
    }
    
    // MARK: - Methods
    
    func updateCharacterData() {
        updateOrigin()
        updateEpisodes()
    }
    
    // MARK: - Origin update
    
    private func updateOrigin() {
        guard character.originContainer.location == nil else { return }
        let url = character.originContainer.url
        
        networkManager.fetchLocation(endpoint: .directUrl(url)) { [weak self] result in
            switch result {
            case .success(let fetchedLocation):
                self?.character.originContainer.location = fetchedLocation
                self?.objectWillChange.send()
            case .failure(let error):
                self?.handleError(message: "Failed to load origin.", error)
            }
        }
    }
    
    // MARK: - Episodes update
    
    private func updateEpisodes() {
        let episodeIds = character.episodeContainer.filter({ $0.value == nil }).map { $0.key }
        let isMultipleIds = episodeIds.count > 1
        let isSingleId = episodeIds.count == 1
        
        if isMultipleIds {
            fetchEpisodeMultiple(withIds: episodeIds)
        } else if isSingleId, let id = episodeIds.first {
            fetchEpisodeSingle(withId: id)
        }
    }
    
    private func fetchEpisodeMultiple(withIds ids: [Int]) {
        networkManager.fetchEpisodeMultiple(endpoint: .getMultiple(episodeIds: ids)) { [weak self] result in
            self?.processEpisodeFetchResult(result, completion: { fetchedEpisodes in
                fetchedEpisodes.forEach { fetchedEpisode in
                    self?.updateEpisodeContainer(with: fetchedEpisode)
                }
                return self?.obtainEpisodesFromContainer() ?? []
            })
        }
    }
    
    private func fetchEpisodeSingle(withId id: Int) {
        networkManager.fetchEpisodeSingle(endpoint: .getSingle(episodeId: id)) { [weak self] result in
            self?.processEpisodeFetchResult(result) { fetchedEpisode in
                self?.updateEpisodeContainer(with: fetchedEpisode)
                return self?.obtainEpisodesFromContainer() ?? []
            }
        }
    }
    
    private func processEpisodeFetchResult<T>(_ result: Result<T, FetchError>, completion: (T) -> [EpisodeModel]) {
        switch result {
        case .success(let fetchResult):
            self.episodes = completion(fetchResult)
        case .failure(let error):
            handleError(message: "Failed to load episodes.", error)
        }
    }
    
    private func updateEpisodeContainer(with episode: Episode) {
        character.episodeContainer.updateValue(EpisodeModel(episode: episode), forKey: episode.id)
    }
    
    private func obtainEpisodesFromContainer() -> [EpisodeModel] {
        return character.episodeContainer.compactMap { $0.value }
    }
}

extension CharacterDetailViewModel {
    private func handleError(message: String, _ error: Error) {
        print("\(message) \(error.localizedDescription)")
    }
}
