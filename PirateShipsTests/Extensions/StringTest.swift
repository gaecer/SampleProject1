//
//  StringTest.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

import XCTest
@testable import PirateShips

class StringTest: XCTestCase {
    var stringToTest = ""
    let value = "String to test"

    override func setUp() {
        stringToTest = value
    }

    override func tearDown() {
        stringToTest = ""
    }

    func test_string_value_when_speech() throws {
        stringToTest.speech()
        XCTAssertEqual(stringToTest, value)
    }
}
