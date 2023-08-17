//
//  CharactersListViewModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

protocol CharactersListViewModelDelegate: AnyObject {
    var characterModelList: [CharacterModel] { get }
    var characterModelListDidChangeHandler: (([CharacterModel]) -> Void)? { get set }
    func viewDidLoad()
}

class CharactersListViewModel: CharactersListViewModelDelegate {
    
    var characterModelList: [CharacterModel] = [] {
        didSet {
            characterModelListDidChangeHandler?(characterModelList)
        }
    }
    
    var characterModelListDidChangeHandler: (([CharacterModel]) -> Void)?
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func viewDidLoad() {
        let sampleData = CharacterResponse.sampleData
        characterModelList = sampleData.results.map { CharacterModel(character: $0) }
    }
}
