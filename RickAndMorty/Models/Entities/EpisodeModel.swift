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
    let airDate: String
    let episodeNum: EpisodeNumber
    
    init(id: Int, name: String, airDate: String, episodeNum: EpisodeNumber) {
        self.id = id
        self.name = name
        self.airDate = airDate
        self.episodeNum = episodeNum
    }
    
    init(episode: Episode) {
        var episodeNum = EpisodeNumber(0,0)
        
        if let eRange = episode.episodeNum.range(of: "E(\\d+)", options: .regularExpression),
           let sRange = episode.episodeNum.range(of: "S(\\d+)", options: .regularExpression) {
            
            let eString = episode.episodeNum[eRange].dropFirst()
            let sString = episode.episodeNum[sRange].dropFirst()
            
            if let e = Int(eString), let s = Int(sString) {
                episodeNum = (e, s)
            }
        }
        
        self.init(id: episode.id, name: episode.name, airDate: episode.airDate, episodeNum: episodeNum)
    }
}
