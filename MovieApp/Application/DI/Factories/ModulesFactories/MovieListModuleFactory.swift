//
//  MovieListModuleFactory.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Swinject
import UIKit

protocol MovieListModuleFactoryProtocol {
    func buildMovieListScreen(delegate: MovieListDelegate?) -> UIViewController
    func buildMovieDetailsScreen(movieModel: MovieModel, onFavoriteDidChange: @escaping () -> Void) -> UIViewController
}

final class MovieListModuleFactory: DIFactory, MovieListModuleFactoryProtocol {
    func buildMovieListScreen(delegate: MovieListDelegate?) -> UIViewController {
        let viewModel = resolver.resolve(MovieListViewModel.self, argument: delegate)!

        let vc = MovieListViewController(viewModel: viewModel)

        return vc
    }

    func buildMovieDetailsScreen(movieModel: MovieModel, onFavoriteDidChange: @escaping () -> Void) -> UIViewController {
        let viewModel = resolver.resolve(MovieDetailsViewModel.self, arguments: movieModel, onFavoriteDidChange)!

        let vc = MovieDetailsViewController(viewModel: viewModel)

        return vc
    }
}
