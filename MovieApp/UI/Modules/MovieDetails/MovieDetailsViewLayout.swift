//
//  MovieDetailsViewLayout.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 23/01/2024.
//

import SnapKit
import UIKit

final class MovieDetailsViewLayout {
    let backgroundImage = UIImageView()
    let titleLabel = UILabel()
    let favoriteButton = UIButton()
    let descriptionLabel = UILabel()
    let scoreLabel = UILabel()
    let releaseDateLabel = UILabel()

    private let bcgImageCoverGradientView = UIView()

    private let view: UIView

    private let gradientLayer = CAGradientLayer()
    private let scrollView = UIScrollView()
    private let scrollContentView = UIView()
    private let contentStack: UIStackView = {
        let stack = UIStackView()

        stack.axis = .vertical
        stack.spacing = 16.0

        return stack
    }()

    private let titleHeaderStack: UIStackView = {
        let stack = UIStackView()

        stack.axis = .horizontal
        stack.spacing = 16.0

        return stack
    }()

    private let favoriteButtonContainer = UIView()

    init(view: UIView) {
        self.view = view

        setup()
    }

    func refreshGradient() {
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.frame = bcgImageCoverGradientView.frame
    }

    private func setup() {
        view.backgroundColor = .systemBackground

        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.backgroundColor = .systemGray3

        contentStack.backgroundColor = .systemBackground
        contentStack.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 0, right: 16.0)
        contentStack.isLayoutMarginsRelativeArrangement = true

        titleLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
        titleLabel.numberOfLines = 0

        scoreLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        scoreLabel.numberOfLines = 0
        scoreLabel.textColor = .systemGray2

        releaseDateLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        releaseDateLabel.numberOfLines = 0
        releaseDateLabel.textColor = .systemGray2

        descriptionLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        descriptionLabel.numberOfLines = 0

        favoriteButton.tintColor = UIColor.systemYellow

        setupViewHierarchy()
        setupConstraints()

        setupPosterGradient()
    }

    private func setupViewHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(scrollView)

        scrollView.addSubview(scrollContentView)

        scrollContentView.addSubview(bcgImageCoverGradientView)
        scrollContentView.addSubview(contentStack)

        contentStack.addArrangedSubview(titleHeaderStack)
        contentStack.addArrangedSubview(scoreLabel)
        contentStack.addArrangedSubview(releaseDateLabel)
        contentStack.addArrangedSubview(descriptionLabel)

        titleHeaderStack.addArrangedSubview(titleLabel)
        titleHeaderStack.addArrangedSubview(favoriteButtonContainer)

        favoriteButtonContainer.addSubview(favoriteButton)
    }

    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        scrollContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        bcgImageCoverGradientView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(backgroundImage.snp.height)
        }

        contentStack.snp.makeConstraints { make in
            make.top.equalTo(bcgImageCoverGradientView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }

        favoriteButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(8.0)
            make.bottom.lessThanOrEqualToSuperview()
            make.size.equalTo(32.0)
        }
    }

    private func setupPosterGradient() {
        bcgImageCoverGradientView.layer.insertSublayer(gradientLayer, at: 0)

        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradientLayer.locations = [0.4, 1.0]

        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)

        view.layoutSubviews()
        gradientLayer.frame = bcgImageCoverGradientView.frame
    }
}
