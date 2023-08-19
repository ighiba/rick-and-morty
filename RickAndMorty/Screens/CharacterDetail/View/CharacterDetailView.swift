//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

private let bottomListPadding: CGFloat = 10
private let horizontalInset: CGFloat = 20

private let avatarViewInsets = EdgeInsets(top: 30, leading: horizontalInset, bottom: 20, trailing: horizontalInset)
private let defaultViewInsets = EdgeInsets(top: 15, leading: horizontalInset, bottom: 15, trailing: horizontalInset)
private let episodeRowInsets = EdgeInsets(top: 8, leading: horizontalInset, bottom: 8, trailing: horizontalInset)
private let episodesTitleInsets = EdgeInsets(top: 8, leading: horizontalInset, bottom: 8, trailing: horizontalInset)

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel: CharacterDetailViewModel
    
    init(viewModel: CharacterDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            UIColor.defaultBackgroundColor.toColor()
                .ignoresSafeArea()
            List {
                makeSection {
                    AvatarView(characterAvatar: $viewModel.characterAvatar)
                }
                .listRowInsets(avatarViewInsets)
                makeSection {
                    InfoView(characterInfo: $viewModel.characterInfo)
                }
                .listRowInsets(defaultViewInsets)
                makeSection {
                    OriginView(originContainer: $viewModel.originContainer)
                }
                .listRowInsets(defaultViewInsets)
                if !viewModel.episodes.isEmpty {
                    makeSection {
                        EpisodesView(episodes: $viewModel.episodes, titleInsets: episodesTitleInsets)
                    }
                    .listRowInsets(episodeRowInsets)
                    makeSection {
                        makeEmptyView(withBottomPadding: bottomListPadding)
                    }
                }
            }
            .listStyle(.plain)
            .animation(.default, value: viewModel.episodes.isEmpty)
            .modifier(ListBackgroundModifier())
        }
    }
    
    private func makeSection<Content: View>(content: () -> Content) -> some View {
        return Section {
            content()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    
    private func makeEmptyView(withBottomPadding padding: CGFloat) -> some View {
        return VStack {}
            .padding(.bottom, padding)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    
    static let sampleData = CharacterResponse.sampleData
    static let sampleCharacter: CharacterModel = sampleData.results.map( { CharacterModel(character: $0) }).first!
    static let sampleViewModel = CharacterDetailViewModel(character: sampleCharacter, networkManager: NetworkManagerImpl())
    
    static var previews: some View {
        CharacterDetailView(viewModel: sampleViewModel)
    }
}
