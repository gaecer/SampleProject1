//
//  Coordinator.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 21/12/2020.
//

import UIKit

protocol Coordinator {
    func showPirateShipDetailController(shipViewModel: PirateShipViewModel)
}

/// Coordinate the navigarion between Views
class CoordinatorImp {

    private let window: UIWindow
    private var navigationController: UINavigationController!

    init(window: UIWindow) {
        self.window = window
        self.start()
    }

    /// Instantiate the first View Controller into a Navigation Controller
    private func start() {
        let service = PirateShipServiceImp()
        let viewModel = PirateShipsListViewModelImp(service: service, coordinator: self)

        guard let pirateListViewController = PirateShipsListCollectionViewController(viewModel: viewModel)
        else { return }

        navigationController = UINavigationController(rootViewController: pirateListViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

extension CoordinatorImp: Coordinator {
    /// Navigate to the Pirate Ship Detail ViewController
    func showPirateShipDetailController(shipViewModel: PirateShipViewModel) {
        let pirateShipDetailView = PirateShipDetail(viewModel: shipViewModel)
        navigationController.pushViewController(pirateShipDetailView, animated: true)
    }
}
