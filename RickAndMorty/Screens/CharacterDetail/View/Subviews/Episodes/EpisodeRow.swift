//
//  EpisodeRow.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import SwiftUI

struct EpisodeRow: View {
    
    var episode: EpisodeModel
    
    private let rowHeight: CGFloat = 86
    private let cornerRadius: CGFloat = 16
    private let horizontalPadding: CGFloat = 16
    private let bottomMinSpacing: CGFloat = 12
    
    private let episodeNameFont: Font = .gilroySemibold(17)
    private let episodeNumFont: Font = .gilroyMedium(13)
    private let episodeAirDateFont: Font = .gilroyMedium(12)
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text(episode.name)
                .font(episodeNameFont)
                .foregroundColor(UIColor.mainTextColor.toColor())
                .padding([.leading, .trailing], horizontalPadding)
            Spacer(minLength: 1)
            HStack {
                Text("Episode: \(episode.episodeNum.e), Season: \(episode.episodeNum.s)")
                    .font(episodeNumFont)
                    .foregroundColor(UIColor.greenAccentColor.toColor())
                Spacer()
                Text(episode.airDate)
                    .font(episodeAirDateFont)
                    .foregroundColor(UIColor.secondaryTextColor2.toColor())
            }
            .padding([.leading, .trailing], horizontalPadding)
            Spacer(minLength: bottomMinSpacing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: rowHeight)
        .background(UIColor.cellBackgroundColor.toColor())
        .cornerRadius(cornerRadius)
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    
    static let sampleData = EpisodeModel(id: 0, name: "Claw and Hoarder: Special Ricktim's Morty", airDate: "December 7, 2013", episodeNum: (1, 1))
    
    static var previews: some View {
        EpisodeRow(episode: sampleData)
            .frame(width: 350)
    }
}
