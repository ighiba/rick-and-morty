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
    var networkErrorHandler: ((Error) -> Void)? { get set }
    func viewDidLoad()
    func refreshList()
    func loadNextPage()
}

class CharactersListViewModel: CharactersListViewModelDelegate {
    
    enum ListAction {
        case append
        case replace
    }
    
    // MARK: - Properties
    
    var characterModelList: [CharacterModel] = [] {
        didSet {
            characterModelListDidChangeHandler?(characterModelList)
        }
    }
    
    var characterModelListDidChangeHandler: (([CharacterModel]) -> Void)?
    var networkErrorHandler: ((Error) -> Void)?
    
    var networkManager: NetworkManager
    var pagingService: PagingService
    
    private var isLoading: Bool = false
    
    // MARK: - Init
    
    init(networkManager: NetworkManager, pagingService: PagingService) {
        self.networkManager = networkManager
        self.pagingService = pagingService
    }
    
    // MARK: - Methods
    
    func viewDidLoad() {
        loadFirstPage()
    }
    
    func refreshList() {
        loadFirstPage()
    }
    
    private func loadFirstPage() {
        loadCharactersData(endpoint: .getCharacters(page: 1), listAction: .replace)
    }
    
    func loadNextPage() {
        loadCharactersData(endpoint: .directUrl(pagingService.nextPageUrl), listAction: .append, usingPagingService: pagingService)
    }
    
    private func loadCharactersData(endpoint: API.Character, listAction: ListAction, usingPagingService pagingService: PagingService? = nil) {
        guard pagingService?.isNextAvailable ?? true, !isLoading else { return }
        isLoading = true
        networkManager.fetchCharacters(endpoint: endpoint) { [weak self] result in
            self?.processCharactersFetchResult(result, listAction: listAction)
            self?.isLoading = false
        }
    }
    
    private func processCharactersFetchResult(_ result: CharactersFetchResult, listAction: ListAction) {
        switch result {
        case .success(let response):
            processCharactersResponse(response, listAction: listAction)
        case .failure(let error):
            print("Failed to load characters. \(error.localizedDescription)")
            networkErrorHandler?(error)
        }
    }
    
    private func processCharactersResponse(_ response: CharacterResponse, listAction: ListAction) {
        let (info, results) = (response.info, response.results)
        pagingService.nextPageUrl = info.next
        let newCharactersModelList = results.map { CharacterModel(character: $0) }
        processModelList(newCharactersModelList, listAction: listAction)
    }
    
    private func processModelList(_ charactersModelList: [CharacterModel], listAction: ListAction) {
        switch listAction {
        case .append:
            characterModelList += charactersModelList
        case .replace:
            characterModelList = charactersModelList
        }
    }
}
