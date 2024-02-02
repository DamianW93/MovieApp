//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 23/01/2024.
//

import Combine
import UIKit

class MovieDetailsViewController: UIViewController {
    let viewModel: MovieDetailsViewModel

    private var layout: MovieDetailsViewLayout!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.movieModel.title

        setup()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let layout else { return }

        layout.refreshGradient()
    }

    private func setup() {
        layout = MovieDetailsViewLayout(view: view)

        layout.favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }

    @objc private func didTapFavoriteButton() {
        viewModel.didTapOnFavoriteButton()
    }
}

// MARK: - Bindings

extension MovieDetailsViewController {
    func bindViewModel() {
        viewModel.$movieModel
            .receive(on: RunLoop.main)
            .sink { [weak self] movie in
                self?.setupLayout(with: movie)
            }
            .store(in: &cancellables)
    }

    private func setupLayout(with model: MovieModel) {
        layout.backgroundImage.kf.setImage(with: model.bigImageUrl)
        layout.titleLabel.text = model.title
        layout.descriptionLabel.text = model.overview
        layout.favoriteButton.setImage(
            UIImage(systemName: model.isFavorite ? "star.fill": "star"),
            for: .normal
        )

        let voteValue = String(format: "%.1f", model.voteAverage)
        let score = "Rating: \(voteValue) / 10.0"
        layout.scoreLabel.text = score

        let date = model.releaseDate.format(.yearMonthDay)
        layout.releaseDateLabel.text = date
    }
}
