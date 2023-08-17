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
    private let horizontalSpacing: CGFloat = 16
    private let verticalSpacing: CGFloat = 8
    
    private let episodeNameFont: Font = .gilroySemibold(17)
    private let episodeNumFont: Font = .gilroyMedium(13)
    private let episodeAirDateFont: Font = .gilroyMedium(12)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(episode.name)
                .font(episodeNameFont)
                .foregroundColor(.white)
                .padding(.bottom, verticalSpacing)
                .padding(.leading, horizontalSpacing)
            HStack {
                Text("Episode: \(episode.episodeNum.e), Season: \(episode.episodeNum.s)")
                    .font(episodeNumFont)
                    .foregroundColor(UIColor.greenAccentColor.toColor())
                Spacer()
                Text(episode.airDate.formatted(date: .long, time: .omitted))
                    .font(episodeAirDateFont)
                    .foregroundColor(UIColor.secondaryTextColor2.toColor())
            }
            .padding([.leading, .trailing], horizontalSpacing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: rowHeight)
        .background(UIColor.cellBackgroundColor.toColor())
        .cornerRadius(cornerRadius)
    }
}

struct EpisodeRow_Previews: PreviewProvider {
    
    static let sampleData = EpisodeModel(id: 0, name: "Pilot", airDate: Date(), episodeNum: (1, 1))
    
    static var previews: some View {
        EpisodeRow(episode: sampleData)
    }
}
