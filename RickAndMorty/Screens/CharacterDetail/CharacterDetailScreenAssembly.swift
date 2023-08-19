//
//  CharacterDetailScreenAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharacterDetailScreenAssembly {
    class func configureScreen(character: CharacterModel) -> UIViewController {
        let viewModel = CharacterDetailViewModel(character: character, networkManager: NetworkManagerImpl())
        let view = CharacterDetailController(viewModel: viewModel)
        
        return view
    }
}
