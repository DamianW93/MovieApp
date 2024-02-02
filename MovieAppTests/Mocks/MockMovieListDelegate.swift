//
//  MockMovieListDelegate.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

@testable import MovieApp

final class MockMovieListDelegate: MovieListDelegate {
    private(set) var didSelectCalled: Bool = false
    private(set) var didSelectMovieArgument: MovieModel?
    private(set) var onFavoriteDidChangeArgument: (() -> Void)?

    func didSelect(movie: MovieModel, onFavoriteDidChange: @escaping () -> Void) {
        didSelectCalled = true
        didSelectMovieArgument = movie
        onFavoriteDidChangeArgument = onFavoriteDidChange
    }
}
