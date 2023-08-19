//
//  DefaultImageRenderer.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 19.08.2023.
//

import UIKit

final class DefaultImageRenderer: UIGraphicsImageRenderer {
    
    static let shared = DefaultImageRenderer(cgSize: .avatarImageSize)
    
    private init(cgSize: CGSize) {
        super.init(size: cgSize, format: UIGraphicsImageRendererFormat.default())
    }
}
