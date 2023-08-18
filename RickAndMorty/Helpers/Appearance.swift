//
//  Appearance.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import UIKit

class Appearance {
    class func configure() {
        UICollectionView.appearance().indicatorStyle = .white
        UIRefreshControl.appearance().tintColor = .white
        UIActivityIndicatorView.appearance().color = .white
    }
}
