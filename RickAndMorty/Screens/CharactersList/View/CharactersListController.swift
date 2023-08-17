//
//  CharactersListController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

private let largeTitleFont: UIFont = .gilroyBold.withSize(28)

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
        setupNavigationBar()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func setupNavigationBar() {
        title = "Characters"
        
        let titleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : largeTitleFont,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .defaultBackgroundColor
        navBarAppearance.largeTitleTextAttributes = titleAttributes
        navBarAppearance.titleTextAttributes = titleAttributes
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.prefersLargeTitles = true
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
