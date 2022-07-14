//
//  MockPirateShipViewModel.swift
//  PirateShipsTests
//
//  Created by Gaetano Cerniglia on 30/12/2020.
//

@testable import PirateShips
import UIKit
import Combine

class MockPirateShipViewModel: PirateShipViewModel {

    var state: ImageTableViewCellModel
    var ship: PirateShipModel
    var downloadImageCalled = false
    var showAlertCalled = false

    var statePublisher: AnyPublisher<ImageTableViewCellModel, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    private lazy var stateSubject = CurrentValueSubject<ImageTableViewCellModel, Never>(state)

    func downloadImageFromUrlString(_ urlString: String) {
        downloadImageCalled = true
    }

    func showAlert(onView view: UIViewController, withTitle title: String) {
        showAlertCalled = true
    }

    init(ship: PirateShipModel) {
        self.ship = ship

        let testShip = TestUtility.SampleStruct()
        state = ImageTableViewCellModel(price: testShip.price, image: testShip.imageData)
    }
}
