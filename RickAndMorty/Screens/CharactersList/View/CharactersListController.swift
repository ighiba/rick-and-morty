//
//  CharactersListController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharactersListViewController: UICollectionViewController {

    var viewModel: CharactersListViewModelDelegate! {
        didSet {
            viewModel.characterModelListDidChangeHandler = { [weak self] _ in
                self?.updateSnapshot()
            }
        }
    }
    
    var charactersListView = CharactersListView()
    var dataSource: DataSource!
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    
    override func loadView() {
        collectionView = charactersListView
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        
        dataSource = DataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return self.configureCell(collectionView: collectionView, itemIdentifier: itemIdentifier, for: indexPath)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

// MARK: - DelegateFlowLayout

extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return charactersListView.calculateItemSize()
    }
}

// MARK: - Delegate

extension CharactersListViewController {
    
}

// MARK: - DataSource

extension CharactersListViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CharacterModel.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CharacterModel.ID>
    
    func updateSnapshot(reloading idsThatChanged: [CharacterModel.ID] = []) {
        let ids = idsThatChanged.filter { id in viewModel.characterModelList.contains(where: { $0.id == id }) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.characterModelList.map { $0.id } )
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
            dataSource.apply(snapshot, animatingDifferences: true)
        } else {
            dataSource.apply(snapshot)
        }
    }
    
    func configureCell(
        collectionView: UICollectionView,
        itemIdentifier: CharacterModel.ID,
        for indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath)
        guard let characterCell = cell as? CharacterCell, let characterModel = viewModel.characterModelList.item(withId: itemIdentifier) else { return cell }
        
        characterCell.configure(with: characterModel)
        
        return characterCell
    }
}
