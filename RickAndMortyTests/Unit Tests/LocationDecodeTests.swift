//
//  LocationDecodeTests.swift
//  RickAndMortyTests
//
//  Created by Ivan Ghiba on 18.08.2023.
//

import Foundation

import XCTest
@testable import RickAndMorty

final class LocationDecodeTests: XCTestCase {

    var decoder: JSONDecoder!
    
    private let jsonData = testJsonLocation

    override func setUp() {
        decoder = JSONDecoder()
    }
    
    override func tearDown() {
        decoder = nil
    }

    func testDecodeLocationId() throws {
        let location = try decoder.decode(Location.self, from: jsonData)

        XCTAssertEqual(location.id, 1, "Failed to decode Location.id")
    }
    
    func testDecodeLocationName() throws {
        let location = try decoder.decode(Location.self, from: jsonData)

        XCTAssertEqual(location.name, "Earth (C-137)", "Failed to decode Location.name")
    }
    
    func testDecodeLocationType() throws {
        let location = try decoder.decode(Location.self, from: jsonData)

        XCTAssertEqual(location.type, "Planet", "Failed to decode Location.type")
    }
}
