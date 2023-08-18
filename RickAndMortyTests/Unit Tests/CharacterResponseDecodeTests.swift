//
//  CharacterResponseDecodeTests.swift
//  RickAndMortyTests
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import XCTest
@testable import RickAndMorty

final class CharacterResponseDecodeTests: XCTestCase {

    var decoder: JSONDecoder!
    
    private let jsonData = testJsonResponse

    override func setUp() {
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
        decoder = nil
    }

    func testDecodeCharacterId() throws {
        let character = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        
        XCTAssertEqual(character.id, 1, "Failed to decode Character.id")
    }
    
    func testDecodeCharacterName() throws {
        let character = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        
        XCTAssertEqual(character.name, "Rick Sanchez", "Failed to decode Character.name")
    }
    
    func testDecodeCharacterStatus() throws {
        let character = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        
        XCTAssertEqual(character.status, "Alive", "Failed to decode Character.status")
    }
    
    func testDecodeCharacterGender() throws {
        let character = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!

        XCTAssertEqual(character.gender, "Male", "Failed to decode Character.gender")
    }
    
    func testDecodeInfoCount() throws {
        let info = try decoder.decode(CharacterResponse.self, from: jsonData).info
        
        XCTAssertEqual(info.count, 826, "Failed to decode CharacterResponse.Info.count")
    }
}
