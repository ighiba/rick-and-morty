//
//  Font.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

extension Font {
    static func gilroyMedium(_ size: CGFloat) -> Font {
        return .custom("gilroy-medium", size: size)
    }
    
    static func gilroySemibold(_ size: CGFloat) -> Font {
        return .custom("gilroy-semibold", size: size)
    }
    
    static func gilroyBold(_ size: CGFloat) -> Font {
        return .custom("gilroy-bold", size: size)
    }
}
