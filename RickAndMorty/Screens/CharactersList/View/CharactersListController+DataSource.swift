//
//  CharactersListController+DataSource.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import UIKit

extension CharactersListController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, CharacterModel.ID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, CharacterModel.ID>
    
    func updateSnapshot(reloading idsThatChanged: [CharacterModel.ID] = []) {
        let ids = idsThatChanged.filter { id in viewModel.characterModelList.contains(where: { $0.id == id }) }
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.characterModelList.map { $0.id } )
        if !ids.isEmpty {
            snapshot.reloadItems(ids)
            dataSource.apply(snapshot, animatingDifferences: true) { [weak self] in
                self?.handleRefreshControlEnd()
            }
        } else {
            dataSource.apply(snapshot) { [weak self] in
                self?.handleRefreshControlEnd()
            }
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
