//
//  CharactersListController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharactersListViewController: UICollectionViewController {

    var viewModel: CharactersListViewModelDelegate!

    var charactersListView = CharactersListView()

    override func loadView() {
        collectionView = charactersListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
