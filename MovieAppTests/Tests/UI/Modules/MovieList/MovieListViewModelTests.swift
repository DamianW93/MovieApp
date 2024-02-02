//
//  MovieListViewModelTests.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

import XCTest

@testable import MovieApp

final class MovieListViewModelTests: XCTestCase {
    private var sut: MovieListViewModel!

    private var moviesRepository: MockMoviesRepository!
    private var movieListDelegate: MockMovieListDelegate!

    override func setUp() {
        super.setUp()

        moviesRepository = MockMoviesRepository()
        movieListDelegate = MockMovieListDelegate()

        sut = MovieListViewModel(moviesRepository: moviesRepository, delegate: movieListDelegate)
    }

    // MARK: - loadData

    func testLoadData_DoesNothing_WhenStateLoadsData() {
        /// Given

        waitForAsyncAction {
            // Call first time to change state to loading
            sut.loadData()
            
            /// When
            sut.loadData()
        }

        /// Then - check for one call that changed state to loading and no second call
        XCTAssertEqual(moviesRepository.fetchNowPlayingMoviesCount, 1)
    }

    func testLoadData_SetsStateToLoading() {
        /// Given

        /// When
        sut.loadData()

        /// Then
        XCTAssertEqual(sut.state, .loading)
    }

    func testLoadData_CallsRepositoryToFetchMovies() {
        /// Given
        waitForAsyncAction {
            /// When
            sut.loadData()
        }

        /// Then
        XCTAssertTrue(moviesRepository.fetchNowPlayingMoviesCalled)
    }

    func testLoadData_SetsStateToEmpty_WhenBackendReturnsEmptyList() {
        /// Given

        moviesRepository.fetchNowPlayingMoviesReturnValue = []

        waitForAsyncAction {
            /// When
            sut.loadData()
        }

        /// Then
        XCTAssertEqual(sut.state, .empty)
    }

    func testLoadData_SetsStateToLoaded_WhenBackendReturnsList() {
        /// Given

        moviesRepository.fetchNowPlayingMoviesReturnValue = [MockMovieModel.mocked]

        waitForAsyncAction {
            /// When
            sut.loadData()
        }

        /// Then
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.movies, [MockMovieModel.mocked])
    }

    func testLoadData_SetsStateToError_WhenMoviesFetchFails() {
        /// Given

        moviesRepository.fetchNowPlayingMoviesError = "Test error"

        waitForAsyncAction {
            /// When
            sut.loadData()
        }

        /// Then
        XCTAssertEqual(sut.state, .error("Test error"))
    }

    // MARK: - onPullToRefresh

    func testOnPullToRefresh_DoesNothing_WhenStateLoadsData() {
        /// Given

        waitForAsyncAction {
            // Call first time to change state to loading
            sut.onPullToRefresh()

            /// When
            sut.onPullToRefresh()
        }

        /// Then
        XCTAssertEqual(moviesRepository.fetchNowPlayingMoviesCount, 1)
    }

    func testOnPullToRefresh_SetsStateToRefreshing() {
        /// Given

        /// When
        sut.onPullToRefresh()

        /// Then
        XCTAssertEqual(sut.state, .refreshing)
    }

    func testOnPullToRefresh_SetsPageToLoadToFirst() {
        /// Given

        // Call first time to increase page
        waitForAsyncAction {
            sut.loadData()
        }

        /// When
        waitForAsyncAction {
            sut.onPullToRefresh()
        }

        /// Then
        XCTAssertEqual(moviesRepository.fetchNowPlayingMoviesPageArgument, 1)
    }

    // MARK: - willDisplayMovie

    func testWillDisplayMovie_DoesNothing_WhenStateLoadsData() {
        /// Given
        waitForAsyncAction {
            // Call first time to change state to loading
            sut.loadData()

            /// When
            sut.willDisplayMovie(at: 0, isCellVisible: true, isContentBiggerThanTable: true)
        }

        /// Then
        XCTAssertEqual(moviesRepository.fetchNowPlayingMoviesCount, 1)
    }

    func testWillDisplayMovie_SetStateToLoadingMore_WhenScrolledToBottom() {
        /// Given
        moviesRepository.fetchNowPlayingMoviesReturnValue = [
            MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked,
            MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked
        ]

        waitForAsyncAction {
            // Call first time to populate list
            sut.loadData()
        }

        /// When
        sut.willDisplayMovie(at: 7, isCellVisible: true, isContentBiggerThanTable: true)

        /// Then
        XCTAssertEqual(sut.state, .loadingMore)
    }

    func testWillDisplayMovie_LoadsNextPage_WhenScrolledToBottom() {
        /// Given
        moviesRepository.fetchNowPlayingMoviesReturnValue = [
            MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked,
            MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked, MockMovieModel.mocked
        ]

        waitForAsyncAction {
            // Call first time to populate list
            sut.loadData()
        }

        /// When
        waitForAsyncAction {
            sut.willDisplayMovie(at: 7, isCellVisible: true, isContentBiggerThanTable: true)
        }

        /// Then
        XCTAssertEqual(moviesRepository.fetchNowPlayingMoviesPageArgument, 2)
    }

    // MARK: - didTapMovie

    func testDidTapMovie_NotifiesDelegateWithMovieModel() {
        /// Given
        moviesRepository.fetchNowPlayingMoviesReturnValue = [MockMovieModel.mocked]

        waitForAsyncAction {
            // Call first time to populate list
            sut.loadData()
        }

        /// When
        sut.didTapMovie(at: 0)

        /// Then
        XCTAssertTrue(movieListDelegate.didSelectCalled)
        XCTAssertEqual(movieListDelegate.didSelectMovieArgument, MockMovieModel.mocked)
    }

    func testDidTapMovie_UpdatesMovieModel_WhenOnFavoriteChangeCalled() {
        /// Given
        moviesRepository.fetchNowPlayingMoviesReturnValue = [MockMovieModel.mocked]

        waitForAsyncAction {
            // Call first time to populate list
            sut.loadData()
        }

        /// When
        sut.didTapMovie(at: 0)

        moviesRepository.isMovieFavoriteReturnValue = true
        movieListDelegate.onFavoriteDidChangeArgument?()

        /// Then
        XCTAssertTrue(sut.movies[0].isFavorite)
        XCTAssertEqual(sut.itemIndexToUpdate, 0)
    }
}

extension XCTestCase {
    public func waitForAsyncAction(timeout: TimeInterval = 0.1, _ action: () -> Void) {
        action()

        let exp = expectation(description: "async action completed")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            exp.fulfill()
        }

        wait(for: [exp])
    }
}
