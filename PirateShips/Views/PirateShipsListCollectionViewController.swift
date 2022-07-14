//
//  ViewController.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 18/12/2020.
//

import UIKit
import NetworkFramework
import Combine

class PirateShipsListCollectionViewController: UICollectionViewController {

    // MARK: - Properties

    private let headerIdentifier = "ShipHeaderIdentifier"
    private let cellIdentifier = "ShipCellIdentifier"
    private let viewModel: PirateShipsListViewModel
    private lazy var subscriptions = Set<AnyCancellable>()
    private weak var coordinator: CoordinatorImp?

    var headerView: PirateShipsListHeader?
    var state: SearchModel = SearchModel() {
        didSet {
            state.isLoading ? showLoadingIndicator() : removeLoadingIndicator()
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    // MARK: - Init

    /// The Init use the Dependency Injection to receive the Search View Model and the Coordinator
    required init?(viewModel: PirateShipsListViewModel,
                   collectionViewLayout layout: StrechHeaderLayout = StrechHeaderLayout()) {
        self.viewModel = viewModel
        let padding = CGFloat(3)
        layout.sectionInset = .init(top: padding, left: padding, bottom: padding + 20, right: padding)

        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        /// register header
        collectionView!.register(PirateShipsListHeader.self,
                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                 withReuseIdentifier: headerIdentifier)

        /// register cell
        collectionView.register(PirateShipCell.self, forCellWithReuseIdentifier: cellIdentifier)

        collectionView.contentInsetAdjustmentBehavior = .never
        setupRefresher()

        // create subscription to the publisher
        viewModel.statePublisher
            .assign(to: \.state, on: self)
            .store(in: &subscriptions)

        searchShips()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    // MARK: - Custom Functions

    private func setupRefresher() {
        collectionView.refreshControl = UIRefreshControl()

        if let refreshControl = collectionView.refreshControl {
            refreshControl.tintColor = .mainRed
            refreshControl.attributedTitle = NSAttributedString(string: "Fetching Data ...")
            refreshControl.bounds = CGRect(x: refreshControl.bounds.origin.x,
                                           y: refreshControl.bounds.origin.y - 20,
                                           width: refreshControl.bounds.size.width,
                                           height: refreshControl.bounds.size.height)
            refreshControl.addTarget(self,
                                     action: #selector(searchShips),
                                     for: .valueChanged)
        }
        collectionView.alwaysBounceVertical = true
    }

    private func showLoadingIndicator() {
        collectionView.refreshControl?.beginRefreshing()
    }

    private func removeLoadingIndicator() {
        collectionView.refreshControl?.endRefreshing()
    }

    @objc private func searchShips() {
        // subscription
        viewModel.searchShips()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: NSLog("request completed")
                case .failure(let error): NSLog("\(error)")
                }
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            })
            .store(in: &subscriptions)
    }

}

// MARK: - UICollectionViewDelegate/DataSource

extension PirateShipsListCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {

        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                     withReuseIdentifier: headerIdentifier,
                                                                     for: indexPath) as? PirateShipsListHeader
        return headerView ?? PirateShipsListHeader()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.pirateShips?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? PirateShipCell
        else { fatalError("PirateShipCell cell could not be created") }

        if let ship = viewModel.pirateShips?[indexPath.row] {
            let cellViewModel = PirateShipViewModelImp(ship: ship)
            cell.configure(with: cellViewModel)
        }
        return cell
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension PirateShipsListCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width - 8, height: width/2)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PirateShipCell {
            viewModel.showDetailView(shipViewModel: cell.viewModel)
        }
    }
}
