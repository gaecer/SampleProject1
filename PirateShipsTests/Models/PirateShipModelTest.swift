//
//  PirateShipModelTest.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

import XCTest
import Foundation
@testable import PirateShips

class PirateShipModelTest: XCTestCase {
    private enum GreetingStrings: String {
        case ah = "Ahoi!"
        case ay = "Aye Aye!"
        case ar = "Arrr!"
        case yo = "Yo ho hooo!"
        case unknown = ""
    }

    func test_greetingType_with_function() throws {
        XCTAssertEqual(GreetingType.ah, GreetingType.ah)
        XCTAssertEqual(GreetingType.ar, GreetingType.ar)
        XCTAssertEqual(GreetingType.ay, GreetingType.ay)
        XCTAssertEqual(GreetingType.yo, GreetingType.yo)
        XCTAssertEqual(GreetingType.unknown, GreetingType.unknown)
    }

    func test_greetingTypeDescription_with_function () throws {
        XCTAssertEqual(GreetingType.ah.description(), GreetingStrings.ah.rawValue)
        XCTAssertEqual(GreetingType.ay.description(), GreetingStrings.ay.rawValue)
        XCTAssertEqual(GreetingType.ar.description(), GreetingStrings.ar.rawValue)
        XCTAssertEqual(GreetingType.yo.description(), GreetingStrings.yo.rawValue)
        XCTAssertEqual(GreetingType.unknown.description(), GreetingStrings.ah.rawValue)
    }

    func test_greetingType_when_notEqual () throws {
        XCTAssertNotEqual(GreetingType.ar, GreetingType.ay)
        XCTAssertNotEqual(GreetingType.yo, GreetingType.ah)
    }
}
