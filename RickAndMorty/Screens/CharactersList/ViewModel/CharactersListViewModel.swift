//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation
import Combine

protocol CharactersListViewModelDelegate: AnyObject {
    var characterModelList: [CharacterModel] { get }
    var characterModelListPublisher: Published<[CharacterModel]>.Publisher { get }
    func viewDidLoad()
}

class CharactersListViewModel: CharactersListViewModelDelegate {
    
    @Published var characterModelList: [CharacterModel] = []
    var characterModelListPublisher: Published<[CharacterModel]>.Publisher { $characterModelList }
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        let sampleData = CharacterResponse.sampleData
        characterModelList = sampleData.results.map { CharacterModel(character: $0) }
    }
}
