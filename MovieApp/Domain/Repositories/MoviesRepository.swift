//
//  MoviesRepository.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

protocol MoviesRepositoryProtocol {
    func fetchNowPlayingMovies(page: Int) async throws -> [MovieModel]
    func addMovieToFavorites(movieId: Int)
    func removeMovieFromFavorites(movieId: Int)
    func isMovieFavorite(movieId: Int) -> Bool
}

final class MoviesRepository: MoviesRepositoryProtocol {
    private let networkService: NetworkServiceProtocol
    private let userDefaultsService: UserDefaultsServiceProtocol

    init(
        networkService: NetworkServiceProtocol,
        userDefaultsService: UserDefaultsServiceProtocol
    ) {
        self.networkService = networkService
        self.userDefaultsService = userDefaultsService
    }

    func fetchNowPlayingMovies(page: Int) async throws -> [MovieModel] {
        let nowPlayingMoviesResponse = try await networkService.request(
            type: NowPlayingMoviesResponseDataModel.self,
            endpoint: MoviesEndpoint.getPlayingNowMovies(
                .init(language: "en", page: String(page))
            )
        )

        let nowPlayingMovies = nowPlayingMoviesResponse.results.map {
            MovieModel.from(
                response: $0,
                isFavorite: userDefaultsService.isMovieFavorite(movieId: $0.id)
            )
        }

        return nowPlayingMovies
    }

    func addMovieToFavorites(movieId: Int) {
        userDefaultsService.addMovieToFavorites(movieId: movieId)
    }

    func removeMovieFromFavorites(movieId: Int) {
        userDefaultsService.removeMovieFromFavorites(movieId: movieId)
    }

    func isMovieFavorite(movieId: Int) -> Bool {
        userDefaultsService.isMovieFavorite(movieId: movieId)
    }
}
