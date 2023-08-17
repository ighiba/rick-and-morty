//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

private let spacingMultiplier: CGFloat = 0.1
private let widthMultipler: CGFloat = 1.0 - spacingMultiplier
private let systemSpacingMultiplier: CGFloat = 1.0 + spacingMultiplier
private let labelSpacing: CGFloat = 3

private let defaultCornerRadius: CGFloat = 10

final class CharacterCell: UICollectionViewCell {
    
    var characterId: CharacterModel.ID?
    static let identifier = "CharacterCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    private func setupViews() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultipler),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: systemSpacingMultiplier),
            imageView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: systemSpacingMultiplier),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: labelSpacing),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -labelSpacing),
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: labelSpacing),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -labelSpacing),
        ])
    }
    
    private func setupStyle() {
        imageView.layer.cornerRadius = defaultCornerRadius
        imageView.backgroundColor = .blue
        
        nameLabel.textColor = .white
    }
    
    func configure(with characterModel: CharacterModel) {
        characterId = characterModel.id
        nameLabel.text = characterModel.name
        imageView.image = characterModel.image?.1
        
        backgroundConfiguration = configureBackground()
    }
    
    private func configureBackground() -> UIBackgroundConfiguration {
        var configuration = UIBackgroundConfiguration.listPlainCell()
        configuration.backgroundColor = .red
        configuration.cornerRadius = defaultCornerRadius
        return configuration
    }
    
    // MARK: - Views
    
    let imageView = UIImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
}
