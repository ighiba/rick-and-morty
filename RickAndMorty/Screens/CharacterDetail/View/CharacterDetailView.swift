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
                makeSection {
                    CharacterAvatarContainer(characterAvatar: viewModel.characterAvatar)
                        .padding(.bottom, verticalSpacing)
                }
                makeSection {
                    CharacterInfoContainer(characterInfo: viewModel.characterInfo)
                        .padding(.bottom, verticalSpacing)
                }
                makeSection {
                    CharacterOriginContainer(originContainer: viewModel.originContainer)
                        .padding(.bottom, verticalSpacing)
                }
                if !viewModel.episodes.isEmpty {
                    makeSection {
                        CharacterEpisodesContainer(episodes: viewModel.episodes)
                    }
                }
            }
            .listStyle(.plain)
        }
    }
    
    private func makeSection<Content: View>(content: () -> Content) -> some View {
        return Section {
            content()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static let sampleData = CharacterResponse.sampleData
    static let sampleCharacter: CharacterModel = sampleData.results.map( { CharacterModel(character: $0) }).first!
    
    static var previews: some View {
        CharacterDetailView(viewModel: .init(character: sampleCharacter))
    }
}
