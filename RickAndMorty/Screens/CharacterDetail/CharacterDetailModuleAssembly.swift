//
//  CharacterDetailModuleAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit
import SwiftUI

class CharacterDetailModuleAssembly {
    class func configureModule(character: CharacterModel) -> UIViewController {
        let viewModel = CharacterDetailViewModel(character: character)
        let rootView = CharacterDetailView(viewModel: viewModel)
        let view = CharacterDetailViewController(rootView: rootView)

        view.viewModel = viewModel
        viewModel.networkManager = NetworkManagerImpl()
        
        return view
    }
}
