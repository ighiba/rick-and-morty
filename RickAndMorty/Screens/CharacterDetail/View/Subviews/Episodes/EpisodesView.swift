//
//  EpisodesView.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

private let titleBottomPadding: CGFloat = 0

struct EpisodesView: View {
    
    @Binding var episodes: [EpisodeModel]
    
    var titleInsets = EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)

    var body: some View {
        TitleHeader(title: "Episodes", bottomPadding: titleBottomPadding)
            .listRowInsets(titleInsets)
        ForEach(episodes) { episode in
            EpisodeRow(episode: episode)
        }
    }
}

struct EpisodesView_Previews: PreviewProvider {
    
    static let sampleData = [
        EpisodeModel(id: 0, name: "Pilot", airDate: "December 7, 2013", episodeNum: (1, 1)),
        EpisodeModel(id: 1, name: "Lawnmower Dog", airDate: "December 17, 2013", episodeNum: (2, 1))
    ]
    
    static var previews: some View {
        EpisodesView(episodes: .constant(sampleData))
            .background(UIColor.cellBackgroundColor.toColor())
    }
}
