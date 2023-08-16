//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

class CharactersListView: UICollectionView {

    init() {
        let defaultLayout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .insetGrouped))
        super.init(frame: .zero, collectionViewLayout: defaultLayout)
        setupStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        
    }
}
