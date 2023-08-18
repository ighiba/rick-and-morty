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
    func loadNextPage()
}

class CharactersListViewModel: CharactersListViewModelDelegate {
    
    var characterModelList: [CharacterModel] = [] {
        didSet {
            characterModelListDidChangeHandler?(characterModelList)
        }
    }
    
    var characterModelListDidChangeHandler: (([CharacterModel]) -> Void)?
    
    var networkManager: NetworkManager
    var pagingService: PagingService
    
    init(networkManager: NetworkManager, pagingService: PagingService) {
        self.networkManager = networkManager
        self.pagingService = pagingService
    }
    
    func viewDidLoad() {
        let sampleData = CharacterResponse.sampleData
        processCharactersResponse(sampleData)
    }
    
    func loadNextPage() {
        print("load next")
        guard pagingService.isNextAvailable, !pagingService.isLoadingNewPage else { return }
        pagingService.isLoadingNewPage = true
        print("start load")
        networkManager.fetchCharacters(endpoint: .directUrl(pagingService.nextPageUrl)) { [weak self] result in
            switch result {
            case .success(let response):
                self?.processCharactersResponse(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self?.pagingService.isLoadingNewPage = false
        }
    }
    
    private func processCharactersResponse(_ charactersResponse: CharacterResponse) {
        let (info, results) = (charactersResponse.info, charactersResponse.results)
        pagingService.nextPageUrl = info.next
        let newCharacterModelList = results.map { CharacterModel(character: $0) }
        characterModelList += newCharacterModelList
    }
}
