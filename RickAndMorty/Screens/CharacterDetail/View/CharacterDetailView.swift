//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    var character: CharacterModel
    
    var body: some View {
        VStack {
            CharacterAvatarContainer(
                imageContainer: character.imageContainer,
                name: character.name,
                status: character.status
            )

        }
        
        VStack {
            Text("Info")
            
            VStack {
                
            }
        }


//        List(character.episodes) { episode in
//            Text(episode.url.absoluteString)
//        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static let sampleData = CharacterResponse.sampleData
    static let sampleCharacter: CharacterModel = sampleData.results.map( { CharacterModel(character: $0) }).first!
    
    static var previews: some View {
        CharacterDetailView(character: sampleCharacter)
    }
}
