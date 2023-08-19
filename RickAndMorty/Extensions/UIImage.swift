//
//  UIImage.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import UIKit

extension UIImage {
    static let characterAvatarPlaceholder = UIImage(named: "CharacterAvatarPlaceholder")!
    static let originPlanet = UIImage(named: "OriginPlanet")!
}

extension UIImage {
    enum ImageQuality: CGFloat {
        case low = 0.25
        case medium = 0.5
        case high = 0.75
    }
    
    func compressed(_ quality: ImageQuality) -> UIImage? {
        guard let jpegData = jpegData(compressionQuality: quality.rawValue) else { return nil }
        return UIImage(data: jpegData)
    }

    func resized(to size: CGSize) -> UIImage {
        return DefaultImageRenderer.shared.image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
