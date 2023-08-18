//
//  CharacterEpisodesContainer.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct CharacterEpisodesContainer: View {
    
    @Binding var episodes: [EpisodeModel]
    
    private let verticalSpacing: CGFloat = 8
    
    var body: some View {
        TitleHeader(title: "Episodes", verticalSpacing: verticalSpacing)
        ForEach(episodes) { episode in
            EpisodeRow(episode: episode)
        }
    }
}

struct EpisodesContainer_Previews: PreviewProvider {
    
    static let sampleData = [
        EpisodeModel(id: 0, name: "Pilot", airDate: "December 7, 2013", episodeNum: (1, 1)),
        EpisodeModel(id: 1, name: "Lawnmower Dog", airDate: "December 17, 2013", episodeNum: (2, 1))
    ]
    
    static var previews: some View {
        CharacterEpisodesContainer(episodes: .constant(sampleData))
            .background(UIColor.cellBackgroundColor.toColor())
    }
}
