//
//  CharactersListController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

private let largeTitleFont: UIFont = .gilroyBold.withSize(28)

class CharactersListController: UICollectionViewController {
    
    // MARK: - Properties

    var viewModel: CharactersListViewModelDelegate! {
        didSet {
            viewModel.characterModelListDidChangeHandler = { [weak self] _ in
                self?.loaderIndicator.stopAnimating()
                self?.updateSnapshot()
            }
            viewModel.networkErrorHandler = { [weak self] _ in
                self?.handleRefreshControlEnd()
            }
        }
    }
    
    var loaderIndicator = LoaderIndicator(style: .large)
    var charactersListView = CharactersListView()
    var dataSource: DataSource!
    
    // MARK: - VC lifecycle
    
    override func loadView() {
        collectionView = charactersListView
        collectionView.delegate = self
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return self.configureCell(collectionView: collectionView, itemIdentifier: itemIdentifier, for: indexPath)
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoaderIndicator()
        setupRefreshControl()
        setupNavigationBar()
        viewModel.viewDidLoad()
    }

    // MARK: - Methods
    
    private func setupLoaderIndicator() {
        loaderIndicator.addToView(view)
    }
    
    private func setupRefreshControl() {
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.tintColor = .mainTextColor
    }
    
    private func setupNavigationBar() {
        title = "Characters"
        
        let appearance = configureNavigationBarAppearance(largeTitleFont: largeTitleFont)
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .mainTextColor
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureNavigationBarAppearance(largeTitleFont: UIFont) -> UINavigationBarAppearance {
        let titleAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font : largeTitleFont,
            NSAttributedString.Key.foregroundColor : UIColor.mainTextColor
        ]
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.backgroundColor = .defaultBackgroundColor
        navBarAppearance.largeTitleTextAttributes = titleAttributes
        navBarAppearance.titleTextAttributes = titleAttributes
        return navBarAppearance
    }
    
    func handleRefreshControlBegin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.viewModel.refreshList()
        }
    }
    
    func handleRefreshControlEnd() {
        guard let isRefreshing = collectionView.refreshControl?.isRefreshing, isRefreshing else { return }
        collectionView.refreshControl?.endRefreshing()
    }
}

// MARK: - DelegateFlowLayout

extension CharactersListController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return charactersListView.calculateItemSize()
    }
}

// MARK: - Delegate

extension CharactersListController {
    
    private var loadNextPageCellsOffset: Int { 4 }
    
    // Handle loading next page
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= viewModel.characterModelList.count - loadNextPageCellsOffset - 1 {
            viewModel.loadNextPage()
        }
    }
    
    // Refresh control handling only when user drops scroll viw
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let isRefreshing = collectionView.refreshControl?.isRefreshing, isRefreshing {
            handleRefreshControlBegin()
        }
    }

    // Cell selection handling
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCharacter = characterModel(forIndexPath: indexPath) {
            openDetail(forCharacter: selectedCharacter)
        }
    }
    
    private func characterModel(forIndexPath indexPath: IndexPath) -> CharacterModel? {
        let row = indexPath.row
        guard viewModel.characterModelList.indices.contains(row) else { return nil }
        return viewModel.characterModelList[row]
    }
    
    private func openDetail(forCharacter character: CharacterModel) {
        let detailView = CharacterDetailScreenAssembly.configureScreen(character: character)
        navigationController?.pushViewController(detailView, animated: true)
    }
}
