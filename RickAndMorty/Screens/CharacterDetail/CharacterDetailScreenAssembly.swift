//
//  CharacterDetailScreenAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit
import SwiftUI

class CharacterDetailScreenAssembly {
    class func configureScreen(character: CharacterModel) -> UIViewController {
        let viewModel = CharacterDetailViewModel(character: character)
        let rootView = CharacterDetailView(viewModel: viewModel)
        let view = CharacterDetailController(rootView: rootView)

        view.viewModel = viewModel
        viewModel.networkManager = NetworkManagerImpl()
        
        return view
    }
}
