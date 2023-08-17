//
//  CharacterResponseTests.swift
//  RickAndMortyTests
//
//  Created by Ivan Ghiba on 17.08.2023.
//

import XCTest
@testable import RickAndMorty

final class DecodingTests: XCTestCase {

    var decoder: JSONDecoder!

    override func setUp() {
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
        decoder = nil
    }

    func testDecodeCharacterId() throws {
        let jsonData = testJsonResponse
        
        let result = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        let id = result.id
        
        XCTAssertEqual(id, 1, "Failed to decode id")
    }
    
    func testDecodeCharacterName() throws {
        let jsonData = testJsonResponse
        
        let result = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        let name = result.name
        
        XCTAssertEqual(name, "Rick Sanchez", "Failed to decode name")
    }
    
    func testDecodeCharacterStatus() throws {
        let jsonData = testJsonResponse
        
        let result = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        let status = result.status
        
        XCTAssertEqual(status, "Alive", "Failed to decode status")
    }
    
    func testDecodeCharacterGender() throws {
        let jsonData = testJsonResponse
        
        let result = try decoder.decode(CharacterResponse.self, from: jsonData).results.first!
        let gender = result.gender
        
        XCTAssertEqual(gender, "Male", "Failed to decode gender")
    }
    
    func testDecodeInfoCount() throws {
        let jsonData = testJsonResponse
        
        let info = try decoder.decode(CharacterResponse.self, from: jsonData).info
        let count = info.count
        
        XCTAssertEqual(count, 826, "Failed to decode count")
    }
}
