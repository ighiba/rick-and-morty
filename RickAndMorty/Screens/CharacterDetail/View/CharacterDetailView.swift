//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    var character: CharacterModel
    
    private let verticalSpacing: CGFloat = 24
    
    var body: some View {
        ZStack {
            UIColor.defaultBackgroundColor.toColor()
                .ignoresSafeArea()
            VStack(alignment: .center) {
                CharacterAvatarContainer(
                    imageContainer: character.imageContainer,
                    name: character.name,
                    status: character.status
                )
                .padding(.bottom, verticalSpacing)
                CharacterInfoContainer(
                    species: character.species,
                    type: character.type,
                    gender: character.gender
                )
                
                
            }
            .frame(maxWidth: .infinity)
            
    //        List(character.episodes) { episode in
    //            Text(episode.url.absoluteString)
    //        }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static let sampleData = CharacterResponse.sampleData
    static let sampleCharacter: CharacterModel = sampleData.results.map( { CharacterModel(character: $0) }).first!
    
    static var previews: some View {
        CharacterDetailView(character: sampleCharacter)
    }
}
