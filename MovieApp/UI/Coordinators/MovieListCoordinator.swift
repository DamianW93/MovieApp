//
//  MovieListCoordinator.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import UIKit

final class MovieListCoordinator: BaseCoordinator {
    private let navigationController: UINavigationController
    private let movieListModuleFactory: MovieListModuleFactoryProtocol

    init(
        navigationController: UINavigationController,
        movieListModuleFactory: MovieListModuleFactoryProtocol
    ) {
        self.navigationController = navigationController
        self.movieListModuleFactory = movieListModuleFactory
    }

    override func start() {
        rootViewController = movieListModuleFactory.buildMovieListScreen(delegate: self)
    }
}

extension MovieListCoordinator: MovieListDelegate {
    func didSelect(movie: MovieModel, onFavoriteDidChange: @escaping () -> Void) {
        let movieDetails = movieListModuleFactory.buildMovieDetailsScreen(
            movieModel: movie,
            onFavoriteDidChange: onFavoriteDidChange
        )

        navigationController.present(movieDetails, animated: true)
    }
}
