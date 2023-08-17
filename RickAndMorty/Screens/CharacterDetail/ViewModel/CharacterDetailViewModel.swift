//
//  CharacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

protocol CharacterDetailViewModelDelegate: AnyObject {
    var character: CharacterModel { get }
    var characterDidChangeHandler: ((CharacterModel) -> Void)? { get set }
}

class CharacterDetailViewModel: CharacterDetailViewModelDelegate {
    
    var character: CharacterModel {
        didSet {
            characterDidChangeHandler?(character)
        }
    }
    
    var characterDidChangeHandler: ((CharacterModel) -> Void)?
    
    init(character: CharacterModel) {
        self.character = character
    }
}
