//
//  MockMoviesRepository.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

@testable import MovieApp

final class MockMoviesRepository: MoviesRepositoryProtocol {
    // MARK: - fetchNowPlayingMovies

    private(set) var fetchNowPlayingMoviesCalled: Bool = false
    private(set) var fetchNowPlayingMoviesCount: Int = 0
    private(set) var fetchNowPlayingMoviesPageArgument: Int?

    var fetchNowPlayingMoviesReturnValue: [MovieModel]?
    var fetchNowPlayingMoviesError: Error?

    func fetchNowPlayingMovies(page: Int) async throws -> [MovieModel] {
        fetchNowPlayingMoviesCalled = true
        fetchNowPlayingMoviesCount += 1
        fetchNowPlayingMoviesPageArgument = page

        if let fetchNowPlayingMoviesReturnValue {
            return fetchNowPlayingMoviesReturnValue
        } else if let fetchNowPlayingMoviesError {
            throw fetchNowPlayingMoviesError
        } else {
            return []
        }
    }

    // MARK: - addMovieToFavorites

    private(set) var addMovieToFavoritesCalled: Bool = false
    private(set) var addMovieToFavoritesIdArgument: Int?

    func addMovieToFavorites(movieId: Int) {
        addMovieToFavoritesCalled = true
        addMovieToFavoritesIdArgument = movieId
    }

    // MARK: - removeMovieFromFavorites

    private(set) var removeMovieFromFavoritesCalled: Bool = false
    private(set) var removeMovieFromFavoritesIdArgument: Int?

    func removeMovieFromFavorites(movieId: Int) {
        removeMovieFromFavoritesCalled = true
        removeMovieFromFavoritesIdArgument = movieId
    }

    // MARK: - isMovieFavorite

    private(set) var isMovieFavoriteCalled: Bool = false
    private(set) var isMovieFavoriteIdArgument: Int?

    var isMovieFavoriteReturnValue: Bool?

    func isMovieFavorite(movieId: Int) -> Bool {
        isMovieFavoriteCalled = true
        isMovieFavoriteIdArgument = movieId

        if let isMovieFavoriteReturnValue {
            return isMovieFavoriteReturnValue
        } else {
            return false
        }
    }
}
