//
//  UIImageView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ image: UIImage, duration: TimeInterval = 0.3, options: UIView.AnimationOptions = [.transitionCrossDissolve]) {
        UIView.transition(with: self, duration: duration, options: options) { [weak self] in
            self?.image = image
        }
    }
}
