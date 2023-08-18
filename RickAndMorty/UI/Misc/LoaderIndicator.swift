//
//  LoaderIndicator.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import UIKit

private let indicatorHeight: CGFloat = 50

final class LoaderIndicator: UIActivityIndicatorView {
    
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        hidesWhenStopped = true
        startAnimating()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addToView(_ superview: UIView) {
        superview.addSubview(self)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: indicatorHeight),
            self.heightAnchor.constraint(equalToConstant: indicatorHeight),
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor),
        ])
    }
}
