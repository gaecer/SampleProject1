//
//  ViewController.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 18/12/2020.
//

import UIKit
import Combine

class PirateShipDetail: UIViewController {

    // MARK: - UI Properties

    private var activityIndicator: UIActivityIndicatorView = {
        var activityView = UIActivityIndicatorView(style: .large)
        activityView.color = .mainRed
        activityView.startAnimating()
        return activityView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldLargeFont
        label.textColor = .textBrightColor
        label.numberOfLines = 0
        label.accessibilityIdentifier = "titleLabel"
        label.text = ""
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldRegularFont
        label.textColor = .textBrightColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "descriptionLabel"
        label.text = ""
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "pirate")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = "imageView"
        return imageView
    }()

    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let greetingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Greeting", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.setTitleColor(.buttonColor, for: .normal)
        button.accessibilityIdentifier = "greetingButton"
        return button
    }()

    // MARK: - Properties

    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: PirateShipViewModel

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    // MARK: - Init

    internal init(viewModel: PirateShipViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        view.backgroundColor = .darkBackgroundColor

        view.addSubview(verticalStackView)
        verticalStackView.anchor(top: view.topAnchor,
                                 leading: view.leadingAnchor,
                                 trailing: view.trailingAnchor)

        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false
        imageContainer.addSubview(imageView)
        imageView.fillSuperview()
        imageView.anchor(height: 250)
        verticalStackView.addArrangedSubview(imageContainer)

        imageContainer.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()

        verticalStackView.addArrangedSubview(titleLabel)
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(descriptionLabel)
        descriptionLabel.fillSuperview()
        verticalStackView.addArrangedSubview(containerView)
        verticalStackView.addArrangedSubview(greetingButton)

        self.viewModel.statePublisher
            .sink { [weak self] state in
                self?.update(with: state)
            }.store(in: &subscriptions)
        viewModel.downloadImageFromUrlString(viewModel.ship.image)
    }

    // MARK: - Custom Functions

    /// update theUI with the new values
    private func update(with state: ImageTableViewCellModel) {
        imageView.image = state.image
        titleLabel.text = state.title
        descriptionLabel.text = state.description
        greetingButton.setTitle(state.price.formattedPrice(), for: .normal)
        activityIndicator.isHidden = !state.isLoading
        state.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    // MARK: - Actions

    @objc private func buttonAction(_ sender: UIButton!) {
        var title = GreetingType.ah.description()
        if let greetingTypeDescription = viewModel.ship.greetingType?.description() {
            title = greetingTypeDescription
        }
        viewModel.showAlert(onView: self, withTitle: title)
    }

}
