//
//  MockService.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

import NetworkFramework

@testable import PirateShips

class MockPirateShipService: PirateShipService {
    var searchShipsCalled = false

    func searchShips(completion: @escaping (SearchResult) -> Void) -> Cancellable? {
        searchShipsCalled = true
        let ships = TestUtility.getShips()
        completion(.success(ships))
        return nil
    }
}
