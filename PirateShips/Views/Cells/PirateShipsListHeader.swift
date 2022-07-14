//
//  ShipsListHeader.swift
//  PirateShips
//
//  Created by Gaetano Cerniglia on 22/12/2020.
//

import UIKit

class PirateShipsListHeader: UICollectionReusableView {

    // MARK: - Properties

    let headerImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "pirateShipHeader"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Pirate Ship application"
        titleLabel.font = .boldLargeFont
        titleLabel.textColor = .textBrightColor
        return titleLabel
    }()

    let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Interview Task by Gaetano Cerniglia"
        subtitleLabel.font = .boldRegularFont
        subtitleLabel.textColor = .textBrightColor
        return subtitleLabel
    }()

    var animator: UIViewPropertyAnimator!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .textBrightColor

        addSubview(headerImageView)
        headerImageView.fillSuperview()

        setupGradientLayer()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Custom Functions

    private func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.darkBackgroundColor.cgColor]
        gradientLayer.locations = [0.7, 1]
        gradientLayer.frame = self.bounds
        gradientLayer.frame.origin.y -= bounds.height

        let gradientContainerView = UIView()
        addSubview(gradientContainerView)
        gradientContainerView.anchor(leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        gradientContainerView.layer.addSublayer(gradientLayer)

        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.anchor(leading: leadingAnchor,
                         bottom: bottomAnchor,
                         trailing: trailingAnchor,
                         paddingTop: 0,
                         paddingLeft: 10,
                         paddingBottom: 10,
                         paddingRight: 10)
    }

}
