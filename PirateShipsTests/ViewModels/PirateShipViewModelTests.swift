//
//  PirateShipsTests.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 18/12/2020.
//

import XCTest
@testable import PirateShips

class PirateShipViewModelTests: XCTestCase {

    private var pirateShipViewModel: PirateShipViewModel!
    private let testShip = TestUtility.SampleStruct()

    override func setUp() {
        let ships = TestUtility.getShips()
        pirateShipViewModel = PirateShipViewModelImp(ship: ships.last!)
    }

    override func tearDown() {
        pirateShipViewModel = nil
    }

    func test_ship_values_after_init() throws {
        let ship = pirateShipViewModel.ship

        XCTAssertNotNil(ship)
        XCTAssertEqual(ship.title, testShip.title)
        XCTAssertEqual(ship.description, testShip.description)
        XCTAssertEqual(ship.price, testShip.price)
        XCTAssertEqual(ship.image, testShip.image)

        switch ship.greetingType {
        case testShip.greetingType:
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }

    func test_state_values_after_init() throws {
        let state = pirateShipViewModel.state

        XCTAssertNotNil(state)
        XCTAssertEqual(state.title, testShip.title)
        XCTAssertEqual(state.description, testShip.description)
        XCTAssertEqual(state.price, testShip.price)
        XCTAssertEqual(state.image, testShip.imageData)

        switch state.greetingType {
        case testShip.greetingType:
            XCTAssert(true)
        default:
            XCTAssert(false)
        }
    }
}
