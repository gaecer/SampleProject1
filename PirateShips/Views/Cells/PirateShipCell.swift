//
//  ShipCell.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 22/12/2020.
//

import UIKit
import Combine

class PirateShipCell: UICollectionViewCell {

    // MARK: - UI Properties

    var activityIndicator: UIActivityIndicatorView = {
        var activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .mainRed
        activityView.startAnimating()
        return activityView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldRegularFont
        label.textColor = .textBrightColor
        label.accessibilityIdentifier = "cellTitleLabel"
        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .boldRegularFont
        label.textColor = .textBrightColor
        label.accessibilityIdentifier = "cellPriceLabel"
        return label
    }()

    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "pirate")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let orizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .top
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Properties

    private(set) var viewModel: PirateShipViewModel!
    private var subscriptions = Set<AnyCancellable>()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .darkBackgroundColor

        addSubview(verticalStackView)
        verticalStackView.fillSuperview()

        verticalStackView.addArrangedSubview(cellImageView)
        verticalStackView.addArrangedSubview(orizontalStackView)

        orizontalStackView.addArrangedSubview(titleLabel)
        orizontalStackView.addArrangedSubview(priceLabel)
        priceLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        priceLabel.setContentCompressionResistancePriority(.required, for: .vertical)

        addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    /// init properties for reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        subscriptions.removeAll()
        viewModel = nil
        cellImageView.image = nil
        activityIndicator.isHidden = true
    }

    // MARK: - Custom Functions

    /// Cell Setup
    func configure(with viewModel: PirateShipViewModel) {
        self.viewModel = viewModel
        viewModel.statePublisher.sink { [weak self] state in
            self?.update(with: state)
        }
        .store(in: &subscriptions)
        viewModel.downloadImageFromUrlString(viewModel.ship.image)
    }

    /// update theUI with the new values
    private func update(with state: ImageTableViewCellModel) {
        cellImageView.image = state.image
        titleLabel.text = state.title
        priceLabel.text = state.price.formattedPrice()

        activityIndicator.isHidden = !state.isLoading
        state.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
}
