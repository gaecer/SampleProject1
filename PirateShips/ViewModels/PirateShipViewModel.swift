//
//  ShipCellViewModel.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 23/12/2020.
//

import UIKit
import Combine
import NetworkFramework

protocol PirateShipViewModel {
    var ship: PirateShipModel { get }
    func downloadImageFromUrlString(_ urlString: String)
    func showAlert(onView view: UIViewController, withTitle title: String)
    var statePublisher: AnyPublisher<ImageTableViewCellModel, Never> { get }
    var state: ImageTableViewCellModel { get }
}

class PirateShipViewModelImp {
    private (set) var ship: PirateShipModel
    private lazy var stateSubject = CurrentValueSubject<ImageTableViewCellModel, Never>(state)
    private lazy var imageDownloader = ImageDownloader.default
    private var placeholderImage: UIImage = #imageLiteral(resourceName: "pirate")
    private var currentDownload: NetworkFramework.Cancellable?

    var state: ImageTableViewCellModel {
        didSet {
            /// On new image received send the notificatio to the subcribers
            stateSubject.send(state)
        }
    }

    internal init(ship: PirateShipModel) {
        self.ship = ship
        self.state = ImageTableViewCellModel(isLoading: true,
                                             title: ship.title,
                                             description: ship.description,
                                             price: ship.price,
                                             image: placeholderImage,
                                             greetingType: ship.greetingType)
    }

    private func cancelDownload() {
        currentDownload?.cancel()
    }

}

extension PirateShipViewModelImp: PirateShipViewModel {
    var statePublisher: AnyPublisher<ImageTableViewCellModel, Never> {
        stateSubject.eraseToAnyPublisher()
    }

    /**
     Function to download an Image useing the ImageDownloader class
     - parameter urlString: URL address of the image to download
     */
    func downloadImageFromUrlString(_ urlString: String) {
        cancelDownload()
        guard let url = URL(string: urlString) else { return }
        state.isLoading = true
        currentDownload = imageDownloader.image(at: url, fallbackImage: placeholderImage) { [weak self] in
            self?.state.isLoading = false
            self?.state.image = $0
        }
    }

    /**
     Function to show a standard Alert Controller
     - parameter onView: the to on where the alert will be showed
     - parameter withTitle: title to show in the alert
     */
    func showAlert(onView view: UIViewController, withTitle title: String) {
        let alert = UIAlertController(title: title,
                                      message: "hire this amazing developer",
                                      preferredStyle: .alert)

        view.present(alert, animated: true) {
            let speechMessage = "\(alert.title!), \(alert.message!)"
            speechMessage.speech()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
