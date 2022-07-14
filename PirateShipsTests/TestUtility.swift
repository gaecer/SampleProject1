//
//  MockResponse.swift
//  PirateShipsUITests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

import XCTest
@testable import PirateShips

class TestUtility {

    static var jsonSampleData: Data = {
        if let path = Bundle.main.path(forResource: "Ships", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                XCTFail("bad json string")
                return Data()
            }
        }
        return Data()
    }()

    static func getShips() -> [PirateShipModel] {
        do {
            let decoded = try JSONDecoder().decode(PirateShipResponse.self, from: jsonSampleData)
            let ships = decoded.ships.compactMap { $0 }

            return ships
        } catch let error {
            XCTFail("\(error)")
            return []
        }
    }

    struct SampleStruct {
        var title: String = "Test title."
        var description: String = "Test description"
        var price: Int = 99
        var image: String = ""
        var greetingType: GreetingType = .ah
        var imageData = #imageLiteral(resourceName: "pirate")
    }
}
