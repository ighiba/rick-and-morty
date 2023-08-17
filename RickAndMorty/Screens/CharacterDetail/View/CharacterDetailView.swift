//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @State var character: CharacterModel
    
    private let verticalSpacing: CGFloat = 24

    var body: some View {
        ZStack {
            UIColor.defaultBackgroundColor.toColor()
                .ignoresSafeArea()
            List {
                Section {
                    CharacterAvatarContainer(
                        imageContainer: character.imageContainer,
                        name: character.name,
                        status: character.status
                    )
                    .padding(.bottom, verticalSpacing)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Section {
                    CharacterInfoContainer(
                        species: character.species,
                        type: character.type,
                        gender: character.gender
                    )
                    .padding(.bottom, verticalSpacing)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Section {
                    CharacterOriginContainer(originContainer: character.originContainer)
                    .padding(.bottom, verticalSpacing)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                let episodes = character.episodes.compactMap { $0.episode }
                if !episodes.isEmpty {
                    Section {
                        CharacterEpisodesContainer(episodes: episodes)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
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
