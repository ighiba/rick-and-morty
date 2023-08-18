//
//  CharactersListModuleAssembly.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharactersListModuleAssembly {
    class func configureModule() -> UIViewController {
        let view = CharactersListController()
        
        let networkManager = NetworkManagerImpl()
        let pagingService = PagingServiceImpl()
        let viewModel = CharactersListViewModel(networkManager: networkManager, pagingService: pagingService)
        
        view.viewModel = viewModel

        return UINavigationController(rootViewController: view)
    }
}
