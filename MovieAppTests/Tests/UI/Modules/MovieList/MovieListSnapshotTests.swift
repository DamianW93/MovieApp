//
//  MovieListSnapshotTests.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 02/02/2024.
//

import XCTest
import SnapshotTesting

@testable import MovieApp

final class MovieListSnapshotTest: XCTestCase {
    private var viewModel: MovieListViewModel!
    private var moviesRepository: MockMoviesRepository!
    private var movieListDelegate: MockMovieListDelegate!

    override func setUp() {
        super.setUp()

        moviesRepository = MockMoviesRepository()
        movieListDelegate = MockMovieListDelegate()

        viewModel = MovieListViewModel(
            moviesRepository: moviesRepository,
            delegate: movieListDelegate
        )
    }

    func testMovieListLoadingState() {
        viewModel.state = .loading

        let sut = MovieListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: sut)

        assertSnapshot(of: navigation, as: .image)
    }

    func testMovieListLoadedState() {
        viewModel.state = .loaded
        viewModel.movies = [MockMovieModel.mocked]

        let sut = MovieListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: sut)

        assertSnapshot(of: navigation, as: .image)
    }

    func testMovieListErrorState() {
        viewModel.state = .error("Couldn't load movies, please try again.")

        let sut = MovieListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: sut)

        assertSnapshot(of: navigation, as: .image)
    }

    func testMovieListEmptyState() {
        viewModel.state = .empty

        let sut = MovieListViewController(viewModel: viewModel)
        let navigation = UINavigationController(rootViewController: sut)

        assertSnapshot(of: navigation, as: .image)
    }
}
