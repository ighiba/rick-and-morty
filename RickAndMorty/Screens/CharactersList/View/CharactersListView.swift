//
//  CharactersListView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

private let sectionSpacing: CGFloat = 27
private let lineSpacing: CGFloat = 16
private let heightToWidthMultiplier: CGFloat = 1.3

private let defaultBackgroundColor: UIColor = UIColor(named: "defaultBackgroundColor")!

class CharactersListView: UICollectionView {
    
    lazy var flowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        return layout
    }()

    init() {
        let defaultLayout = UICollectionViewCompositionalLayout.list(using: .init(appearance: .insetGrouped))
        super.init(frame: .zero, collectionViewLayout: defaultLayout)
        self.collectionViewLayout = flowLayout
        setupStyle()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStyle() {
        backgroundColor = defaultBackgroundColor
    }
    
    func calculateItemSize() -> CGSize {
        let width = bounds.width
        let numberOfItemsPerRow: CGFloat = 2
        let spacingSum: CGFloat = flowLayout.minimumLineSpacing * (numberOfItemsPerRow - 1) + sectionSpacing * 2
        let availableWidth = width - spacingSum
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension * heightToWidthMultiplier)
    }
}
