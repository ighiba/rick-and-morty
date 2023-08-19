//
//  CharacterDetailController.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit
import SwiftUI

class CharacterDetailController: UIHostingController<CharacterDetailView>{
    
    weak var viewModel: CharacterDetailViewModelDelegate?
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
        super.init(rootView: CharacterDetailView(viewModel: viewModel))
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
