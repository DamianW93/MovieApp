//
//  MovieListCell.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Kingfisher
import SnapKit
import UIKit

final class MovieListCell: UITableViewCell {
    static let reuseIdentifier = String(describing: MovieListCell.self)

    private let containerStack: UIStackView = {
        let stack = UIStackView()

        stack.axis = .horizontal
        stack.spacing = 16.0

        return stack
    }()

    private let image = UIImageView()
    private let imageContainer = UIView()

    private let titleLabel = UILabel()

    private let favoriteButton = UIButton()
    private let favoriteButtonContainer = UIView()

    private var didTapFavoriteButtonAction: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        selectionStyle = .none

        setupViews()
        setupViewHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(model: MovieModel, didTapFavoriteButtonAction: (() -> Void)?) {
        self.didTapFavoriteButtonAction = didTapFavoriteButtonAction

        titleLabel.text = model.title
        titleLabel.numberOfLines = 0

        favoriteButton.setImage(
            UIImage(systemName: model.isFavorite ? "star.fill" : "star"),
            for: .normal
        )

        if let imageUrl = model.smallImageUrl {
            image.kf.setImage(with: imageUrl)
        }
    }

    private func setupViews() {
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)

        image.layer.cornerRadius = 6.0
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill

        imageContainer.dropShadow(shadowRadius: 6.0)

        favoriteButton.tintColor = UIColor.systemYellow
        favoriteButton.imageView?.contentMode = .scaleAspectFit
    }

    private func setupViewHierarchy() {
        contentView.addSubview(containerStack)

        imageContainer.addSubview(image)
        favoriteButtonContainer.addSubview(favoriteButton)

        containerStack.addArrangedSubview(imageContainer)
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(favoriteButtonContainer)
    }

    private func setupConstraints() {
        containerStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }

        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        imageContainer.snp.makeConstraints { make in
            make.width.equalTo(containerStack.snp.width)
                .multipliedBy(0.4)
                .priority(ConstraintPriority(999))
            make.height.equalTo(imageContainer.snp.width).multipliedBy(0.5)
        }

        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(32)
            make.leading.trailing.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    @objc private func didTapFavoriteButton() {
        didTapFavoriteButtonAction?()
    }
}
