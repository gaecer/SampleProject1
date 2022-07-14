//
//  IntTest.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

import XCTest
@testable import PirateShips

class IntTest: XCTestCase {
    var intToTest = 0
    let value = 10

    override func setUp() {
        intToTest = value
    }

    override func tearDown() {
        intToTest = 0
    }

    func test_when_formatting_integer_into_currency_string() throws {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        let numberToTest = formatter.string(from: value as NSNumber)

        let formattedPrice = intToTest.formattedPrice()
        XCTAssertEqual(formattedPrice, numberToTest)
    }
}
