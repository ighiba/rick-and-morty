//
//  CharactersListController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit
import Combine

class CharactersListViewController: UICollectionViewController {

    var viewModel: CharactersListViewModelDelegate

    var charactersListView = CharactersListView()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CharactersListViewModelDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        collectionView = charactersListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    // MARK: - Methods
    
    private func configureBindings() {
        viewModel.characterModelListPublisher
            .sink { charactersList in
                print(charactersList)
            }
            .store(in: &cancellables)
    }
}
