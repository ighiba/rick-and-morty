//
//  CharacterNameLabel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import UIKit

private let nameLabelFont: UIFont = .gilroySemibold.withSize(17)

final class CharacterNameLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        font = nameLabelFont
        textAlignment = .center
        numberOfLines = 0
    }
}
