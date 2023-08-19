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
    func fetchCharacters(endpoint: API.Character, completion: @escaping (CharactersFetchResult) -> Void)
    func fetchEpisodeSingle(endpoint: API.Episode, completion: @escaping (EpisodeSingleFetchResult) -> Void)
    func fetchEpisodeMultiple(endpoint: API.Episode, completion: @escaping (EpisodeMultipleFetchResult) -> Void)
    func fetchLocation(endpoint: API.Location, completion: @escaping (LocationFetchResult) -> Void)
}

class NetworkManagerImpl: NetworkManager {
    
    private let session = URLSession.shared
    private let validCodes = 200...299
    
    private let decoder = JSONDecoder()
    
    func fetchCharacters(endpoint: API.Character, completion: @escaping (CharactersFetchResult) -> Void) {
        fetch(endpoint: endpoint, completion: completion)
    }
    
    func fetchEpisodeSingle(endpoint: API.Episode, completion: @escaping (EpisodeSingleFetchResult) -> Void) {
        fetch(endpoint: endpoint, completion: completion)
    }
    
    func fetchEpisodeMultiple(endpoint: API.Episode, completion: @escaping (EpisodeMultipleFetchResult) -> Void) {
        fetch(endpoint: endpoint, completion: completion)
    }
    
    func fetchLocation(endpoint: API.Location, completion: @escaping (LocationFetchResult) -> Void) {
        fetch(endpoint: endpoint, completion: completion)
    }
    
    private func fetch<T: Decodable>(endpoint: Endpoint, completion: @escaping (Result<T, FetchError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.badUrl(endpoint: endpoint)))
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in
            var result: Result<T, FetchError>
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let strongSelf = self else {
                result = .failure(.unknown)
                return
            }
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                result = .failure(.unknown)
                return
            }
            
            guard strongSelf.validCodes.contains(httpUrlResponse.statusCode) else {
                result = .failure(.networkError(statusCode: httpUrlResponse.statusCode))
                return
            }
            
            if error == nil, let parsData = data  {
                guard let decodedJson = try? strongSelf.decoder.decode(T.self, from: parsData) else {
                    result = .failure(.decode)
                    return
                }
                result = .success(decodedJson)
            } else {
                result = .failure(.unknown)
            }
        }.resume()
    }
}
