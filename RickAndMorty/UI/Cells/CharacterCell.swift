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

final class CharacterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CharacterCell"
    
    private var characterId: CharacterModel.ID?

    // MARK: - Views
    
    let imageView = UIImageView()
    let nameLabel = CharacterNameLabel()
    
    // MARK: - Init
    
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
        
        nameLabel.textColor = .mainTextColor
    }
    
    func configure(with characterModel: CharacterModel) {
        characterId = characterModel.id
        nameLabel.text = characterModel.avatar.name
        imageView.image = UIImage.characterAvatarPlaceholder
        loadCharacterImage(forCharacter: characterModel)

        backgroundConfiguration = configureBackground()
    }
    
    private func loadCharacterImage(forCharacter character: CharacterModel) {
        let cachedImageLoader = CachedImageLoader.shared
        guard let imageUrl = character.avatar.imageUrl else { return }
        if let cachedImage = cachedImageLoader.cachedImage(forUrl: imageUrl) {
            imageView.image = cachedImage
        } else {
            let id = character.id
            Task {
                let result = await cachedImageLoader.load(url: imageUrl)
                await MainActor.run {
                    processImageLoadResult(result, processedId: id)
                }
            }
        }
    }
    
    private func processImageLoadResult(_ result: ImageLoadResult, processedId id: CharacterModel.ID) {
        switch result {
        case .success(let image):
            guard id == characterId else { return }
            imageView.setImageAnimated(image)
        case .failure(let error):
            print("Failed to load character image for id: \(id). \(error.localizedDescription)")
        }
    }
    
    private func configureBackground() -> UIBackgroundConfiguration {
        var configuration = UIBackgroundConfiguration.listPlainCell()
        configuration.backgroundColor = .cellBackgroundColor
        configuration.cornerRadius = cellCornerRadius
        return configuration
    }
}
