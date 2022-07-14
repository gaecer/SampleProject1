//
//  MockCoordinator.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

@testable import PirateShips

class MockCoordinator: Coordinator {
    var showPirateShipDetailControllerCalled = false

    func showPirateShipDetailController(shipViewModel: PirateShipViewModel) {
        showPirateShipDetailControllerCalled = true
    }
}
