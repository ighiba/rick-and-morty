//
//  CharactersListModuleAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharactersListModuleAssembly {
    class func configureModule() -> UIViewController {
        let viewModel = CharactersListViewModel(networkManager: NetworkManagerImpl())
        let view = CharactersListViewController(viewModel: viewModel)

        return view
    }
}
