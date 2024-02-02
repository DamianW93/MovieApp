//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 23/01/2024.
//

import Combine

final class MovieDetailsViewModel {
    @Published private(set) var movieModel: MovieModel

    private let onFavoriteDidChange: () -> Void
    private let moviesRepository: MoviesRepositoryProtocol

    init(
        movieModel: MovieModel,
        onFavoriteDidChange: @escaping () -> Void,
        moviesRepository: MoviesRepositoryProtocol
    ) {
        self.movieModel = movieModel
        self.onFavoriteDidChange = onFavoriteDidChange
        self.moviesRepository = moviesRepository
    }

    func didTapOnFavoriteButton() {
        if movieModel.isFavorite {
            moviesRepository.removeMovieFromFavorites(movieId: movieModel.id)
        } else {
            moviesRepository.addMovieToFavorites(movieId: movieModel.id)
        }

        movieModel = movieModel.copyWith(isFavorite: !movieModel.isFavorite)
        onFavoriteDidChange()
    }
}
