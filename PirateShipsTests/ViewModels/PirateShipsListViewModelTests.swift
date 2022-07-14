//
//  TestPirateShipDetail.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 28/12/2020.
//

import XCTest
import Combine
@testable import PirateShips

class PirateShipsListViewModelTests: XCTestCase {

    private var pirateShipsListViewModel: PirateShipsListViewModel!
    private var coordinator: MockCoordinator!
    private var service: MockPirateShipService!
    private var ship: PirateShipModel!

    var subscriptions = Set<AnyCancellable>()

    var state: SearchModel = SearchModel()

    override func setUp() {
        coordinator = MockCoordinator()
        service = MockPirateShipService()

        pirateShipsListViewModel = PirateShipsListViewModelImp(service: service, coordinator: coordinator)

        guard let ship = TestUtility.getShips().first else {
            XCTFail("No Ships available")
            return
        }
        self.ship = ship
    }

    override func tearDown() {
        pirateShipsListViewModel = nil
        coordinator = nil
        service = nil
        ship = nil
    }

    func test_showPirateShipDetailViewCalled_when_viewmodel_use_coordinator() throws {
        XCTAssertFalse(coordinator.showPirateShipDetailControllerCalled)
        let pirateShipViewModel = PirateShipViewModelImp(ship: ship)
        pirateShipsListViewModel.showDetailView(shipViewModel: pirateShipViewModel)
        XCTAssertTrue(coordinator.showPirateShipDetailControllerCalled)
    }

}
