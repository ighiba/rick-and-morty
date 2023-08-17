//
//  CharactersListModuleAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharactersListModuleAssembly {
    class func configureModule() -> UIViewController {
        let view = CharactersListViewController()
        let viewModel = CharactersListViewModel(networkManager: NetworkManagerImpl())
        
        view.viewModel = viewModel

        return view
    }
}
