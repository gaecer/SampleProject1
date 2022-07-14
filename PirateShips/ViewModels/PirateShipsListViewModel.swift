//
//  PirateShipsListViewModel.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 21/12/2020.
//

import Combine
import NetworkFramework

struct SearchModel {
    var isLoading = false
}

typealias SearchResultPublisher = AnyPublisher<[PirateShipModel], PirateShipServiceError>

protocol PirateShipsListViewModel {
    func showDetailView(shipViewModel: PirateShipViewModel)
    func searchShips() -> SearchResultPublisher
    var statePublisher: AnyPublisher<SearchModel, Never> { get }
    var pirateShips: [PirateShipModel]? { get }
}

class PirateShipsListViewModelImp {

    private let service: PirateShipService
    private let coordinator: Coordinator
    private var searchReceipt: NetworkFramework.Cancellable?
    private lazy var stateSubject = CurrentValueSubject<SearchModel, Never>(state)
    private (set) var pirateShips: [PirateShipModel]?

    private var state = SearchModel() {
        didSet { stateSubject.send(state) }
    }

    init(service: PirateShipService, coordinator: Coordinator) {
        self.service = service
        self.coordinator = coordinator
    }
}

extension PirateShipsListViewModelImp: PirateShipsListViewModel {
    var statePublisher: AnyPublisher<SearchModel, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    /**
    Function to show the PirateShipDetailController throw the Coordinator
    */
    func showDetailView(shipViewModel: PirateShipViewModel) {
        coordinator.showPirateShipDetailController(shipViewModel: shipViewModel)
    }

    /**
    Function that start the search of the Ships, setting Combine framework to observe and update changes of the response

    - Returns: Publisher that contains an Array of PirateShips objects or erros PirateShipServiceError
    */
    func searchShips() -> SearchResultPublisher {
        searchReceipt?.cancel()
        state.isLoading = true

        let publisher = PassthroughSubject<[PirateShipModel], PirateShipServiceError>()
        searchReceipt = service.searchShips { [weak self] result in
            guard let self = self else { return }
            self.state.isLoading = false
            switch result {
            case .success(let pirateShips):
                self.pirateShips = pirateShips
                publisher.send(pirateShips)
                publisher.send(completion: .finished)
            case .failure(let error):
                publisher.send(completion: .failure(error))
            }
        }
        return publisher.eraseToAnyPublisher()
    }
}
