//
//  CharacterDetailController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit
import SwiftUI

class CharacterDetailViewController<T: View>: UIHostingController<T> {

    var viewModel: CharacterDetailViewModelDelegate! {
        didSet {
            viewModel.characterDidChangeHandler = { [weak self] character in
                // update
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
