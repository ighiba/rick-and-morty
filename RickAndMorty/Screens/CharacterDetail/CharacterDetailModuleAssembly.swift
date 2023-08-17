//
//  CharacterDetailModuleAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharacterDetailModuleAssembly {
    class func configureModule(character: CharacterModel) -> UIViewController {
        let view = CharacterDetailViewController()
        let viewModel = CharacterDetailViewModel(character: character)

        view.viewModel = viewModel
        
        return view
    }
}
