//
//  CharacterDetailController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit
import SwiftUI

class CharacterDetailController<T: View>: UIHostingController<T> {

    weak var viewModel: CharacterDetailViewModelDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        viewModel.updateCharacterData()
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
