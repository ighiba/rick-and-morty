//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @StateObject var viewModel: CharacterDetailViewModel
    
    private let bottomPadding: CGFloat = 24

    var body: some View {
        ZStack {
            UIColor.defaultBackgroundColor.toColor()
                .ignoresSafeArea()
            List {
                makeSection {
                    AvatarView(characterAvatar: $viewModel.characterAvatar)
                        .padding(.bottom, bottomPadding)
                }
                makeSection {
                    InfoView(characterInfo: $viewModel.characterInfo)
                        .padding(.bottom, bottomPadding)
                }
                makeSection {
                    OriginView(originContainer: $viewModel.originContainer)
                        .padding(.bottom, bottomPadding)
                }
                if !viewModel.episodes.isEmpty {
                    makeSection {
                        EpisodesView(episodes: $viewModel.episodes)
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
