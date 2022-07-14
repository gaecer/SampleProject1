//
//  MockPirateShipsListViewModel.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 30/12/2020.
//

@testable import PirateShips
import Combine

class MockPirateShipsListViewModel: PirateShipsListViewModel {
    private lazy var stateSubject = CurrentValueSubject<SearchModel, Never>(state)
    private var state = SearchModel()
    private let service: PirateShipService
    private let coordinator: Coordinator

    var pirateShips: [PirateShipModel]? = TestUtility.getShips()
    var showDetailViewCalled = false
    var searchShipsCalled = false
    var statePublisher: AnyPublisher<SearchModel, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    func searchShips() -> SearchResultPublisher {
        searchShipsCalled = true
        let publisher = PassthroughSubject<[PirateShipModel], PirateShipServiceError>()

        return publisher.eraseToAnyPublisher()
    }

    init(service: PirateShipService, coordinator: Coordinator) {
        self.service = service
        self.coordinator = coordinator
    }

    func showDetailView(shipViewModel: PirateShipViewModel) {
        showDetailViewCalled = true
    }
}
