//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    private let verticalSpacing: CGFloat = 24

    var body: some View {
        ZStack {
            UIColor.defaultBackgroundColor.toColor()
                .ignoresSafeArea()
            List {
                Section {
                    CharacterAvatarContainer(characterAvatar: viewModel.characterAvatar)
                    .padding(.bottom, verticalSpacing)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Section {
                    CharacterInfoContainer(characterInfo: viewModel.characterInfo)
                    .padding(.bottom, verticalSpacing)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                Section {
                    CharacterOriginContainer(originContainer: viewModel.originContainer)
                    .padding(.bottom, verticalSpacing)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
                if !viewModel.episodes.isEmpty {
                    Section {
                        CharacterEpisodesContainer(episodes: viewModel.episodes)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .id(UUID())
            .listStyle(.plain)
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static let sampleData = CharacterResponse.sampleData
    static let sampleCharacter: CharacterModel = sampleData.results.map( { CharacterModel(character: $0) }).first!
    
    static var previews: some View {
        CharacterDetailView(viewModel: .init(character: sampleCharacter))
    }
}
