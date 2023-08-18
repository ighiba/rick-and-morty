//
//  EpisodeDecodeTests.swift
//  RickAndMortyTests
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

import XCTest
@testable import RickAndMorty

final class EpisodeDecodeTests: XCTestCase {

    var decoder: JSONDecoder!
    
    private let jsonData = testJsonEpisode

    override func setUp() {
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
        decoder = nil
    }

    func testDecodeEpisodeId() throws {
        let episode = try decoder.decode(Episode.self, from: jsonData)

        XCTAssertEqual(episode.id, 1, "Failed to decode Episode.id")
    }
    
    func testDecodeEpisodeName() throws {
        let episode = try decoder.decode(Episode.self, from: jsonData)

        XCTAssertEqual(episode.name, "Pilot", "Failed to decode Episode.name")
    }
    
    func testDecodeEpisodeAirDate() throws {
        let episode = try decoder.decode(Episode.self, from: jsonData)

        XCTAssertEqual(episode.airDate, "December 2, 2013", "Failed to decode Episode.airDate")
    }
    
    func testDecodeEpisodeNum() throws {
        let episode = try decoder.decode(Episode.self, from: jsonData)

        XCTAssertEqual(episode.episodeNum, "S01E01", "Failed to decode Episode.episodeNum")
    }
}
