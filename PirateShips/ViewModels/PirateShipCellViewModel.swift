//
//  ShipCellViewModel.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 23/12/2020.
//

import UIKit
import Combine
import NetworkFramework

/// Cell Model
struct ImageTableViewCellModel {
    var isLoading: Bool = false
    var image: UIImage
    var name: String
    var value: Int
}

class PirateShipViewModel {

    let ship: PirateShipModel

    internal init(ship: PirateShipModel) {
        self.ship = ship
        self.placeholderImage = #imageLiteral(resourceName: "pirate")
        self.state = ImageTableViewCellModel(image: placeholderImage, name: ship.name ?? "", value: ship.value)
    }

    private lazy var stateSubject = CurrentValueSubject<ImageTableViewCellModel, Never>(state)

    private lazy var imageDownloader = ImageDownloader.default
    private var placeholderImage: UIImage

    private var currentDownload: NetworkFramework.Cancellable?

    var statePublisher: AnyPublisher<ImageTableViewCellModel, Never> {
        return stateSubject.eraseToAnyPublisher()
    }

    var state: ImageTableViewCellModel {
        didSet { /// On new image received send the notificatio to the subcribers
            stateSubject.send(state)
        }
    }

    func downloadImage() {
        cancelDownload()
        guard let url = URL(string: ship.image) else { return }
        state.isLoading = true
        currentDownload = imageDownloader.image(at: url, fallbackImage: placeholderImage) { [weak self] in
            self?.state.isLoading = false
            self?.state.image = $0
        }
    }

    private func cancelDownload() {
        currentDownload?.cancel()
    }
}

extension PirateShipViewModel: Hashable {

    static func == (lhs: PirateShipViewModel, rhs: PirateShipViewModel) -> Bool {
        return lhs.ship == rhs.ship
    }

    func hash(into hasher: inout Hasher) { hasher.combine(ship.name) }

}
