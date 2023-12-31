//
//  Array+Identifable.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

extension Array where Element: Identifiable {
    func item(withId id: Element.ID) -> Element? {
        if let index = self.index(for: id) {
            return self[index]
        }
        return nil
    }
    
    func index(for id: Element.ID) -> Int? {
        return self.firstIndex { $0.id == id }
    }
}
