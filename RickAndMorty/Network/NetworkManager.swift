//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

typealias CharactersFetchResult = Result<CharacterResponse, FetchError>
typealias EpisodeSingleFetchResult = Result<Episode, FetchError>
typealias EpisodeMultipleFetchResult = Result<[Episode], FetchError>
typealias LocationFetchResult = Result<Location, FetchError>

protocol NetworkManager: AnyObject {
    func fetchCharacters(endpoint: API.Character) async -> CharactersFetchResult
    func fetchEpisodeSingle(endpoint: API.Episode) async -> EpisodeSingleFetchResult
    func fetchEpisodeMultiple(endpoint: API.Episode) async -> EpisodeMultipleFetchResult
    func fetchLocation(endpoint: API.Location) async -> LocationFetchResult
}

class NetworkManagerImpl: NetworkManager {
    
    private let session = URLSession.shared
    private let validCodes = 200...299
    
    private let decoder = JSONDecoder()
    
    func fetchCharacters(endpoint: API.Character) async -> CharactersFetchResult {
        return await fetch(endpoint: endpoint)
    }
    
    func fetchEpisodeSingle(endpoint: API.Episode) async -> EpisodeSingleFetchResult {
        return await fetch(endpoint: endpoint)
    }
    
    func fetchEpisodeMultiple(endpoint: API.Episode) async -> EpisodeMultipleFetchResult {
        return await fetch(endpoint: endpoint)
    }
    
    func fetchLocation(endpoint: API.Location) async -> LocationFetchResult {
        return await fetch(endpoint: endpoint)
    }

    private func fetch<T: Decodable>(endpoint: Endpoint) async -> Result<T, FetchError> {
        guard let url = endpoint.url else {
            return .failure(.badUrl(endpoint: endpoint))
        }
        
        guard let (data, response) = try? await session.data(from: url) as? (Data, HTTPURLResponse) else {
            return .failure(.unknown)
        }
        
        guard validCodes.contains(response.statusCode) else {
            return .failure(.networkError(statusCode: response.statusCode))
        }
        
        guard let decodedJson = try? self.decoder.decode(T.self, from: data) else {
            return .failure(.decode)
        }
        
        return .success(decodedJson)
    }
}
