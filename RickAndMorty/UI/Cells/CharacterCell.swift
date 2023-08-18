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

private let cellCornerRadius: CGFloat = 16
private let imageViewCornerRadius: CGFloat = 10

private let nameLabelFont: UIFont = .gilroySemibold.withSize(17)

final class CharacterCell: UICollectionViewCell {
    
    static let identifier = "CharacterCell"
    
    private var characterId: CharacterModel.ID?
    
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
        imageView.layer.cornerRadius = imageViewCornerRadius
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .cellImagePlaceholderColor
        
        nameLabel.textColor = .white
    }
    
    func configure(with characterModel: CharacterModel) {
        characterId = characterModel.id
        nameLabel.text = characterModel.avatar.name
        imageView.image = characterModel.avatar.imageContainer?.image
        if characterModel.avatar.imageContainer?.image != nil {
            imageView.image = characterModel.avatar.imageContainer?.image
        } else {
            loadCharacterImage(forCharacter: characterModel)
        }

        backgroundConfiguration = configureBackground()
    }
    
    private func loadCharacterImage(forCharacter character: CharacterModel) {
        guard let imageUrl = character.avatar.imageContainer?.url else { return }
        let id = character.id
        CachedImageLoader.shared.load(url: imageUrl) { [weak self] result in
            switch result {
            case .success(let image):
                guard id == self?.characterId else { return }
                self?.imageView.image = image
                character.avatar.imageContainer?.image = image
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureBackground() -> UIBackgroundConfiguration {
        var configuration = UIBackgroundConfiguration.listPlainCell()
        configuration.backgroundColor = .cellBackgroundColor
        configuration.cornerRadius = cellCornerRadius
        return configuration
    }
    
    // MARK: - Views
    
    let imageView = UIImageView()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = nameLabelFont
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
}
