//
//  CharacterDetailController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    var viewModel: CharacterDetailViewModelDelegate! {
        didSet {
            viewModel.characterDidChangeHandler = { [weak self] character in
                // update
            }
        }
    }

    var characterDetailView = CharacterDetailView()

    override func loadView() {
        view = characterDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
