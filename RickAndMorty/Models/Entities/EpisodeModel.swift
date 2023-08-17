//
//  EpisodeModel.swift
//  RickAndMorty
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import Foundation

typealias EpisodeNumber = (e: Int, s: Int)

struct EpisodeModel: Identifiable {
    let id: Int
    let name: String
    let airDate: Date
    let episodeNum: EpisodeNumber
    
    init(id: Int, name: String, airDate: Date, episodeNum: EpisodeNumber) {
        self.id = id
        self.name = name
        self.airDate = Date()
        self.episodeNum = episodeNum
    }
    
    init(episode: EpisodeModel) {
        self.init(id: episode.id, name: episode.name, airDate: Date(), episodeNum: EpisodeNumber(0, 0))
    }
}
