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
        let rootView = CharacterDetailView(character: character)
        let view = CharacterDetailViewController(rootView: rootView)
        let viewModel = CharacterDetailViewModel(character: character)

        view.viewModel = viewModel
        
        return view
    }
}
