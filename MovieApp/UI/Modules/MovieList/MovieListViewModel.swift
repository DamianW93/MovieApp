//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Combine
import Foundation
import UIKit

protocol MovieListDelegate: AnyObject {
    func didSelect(movie: MovieModel, onFavoriteDidChange: @escaping () -> Void)
}

final class MovieListViewModel: NSObject {
    @Published private(set) var state: MovieListState = .loaded
    @Published private(set) var itemIndexToUpdate: Int?

    private(set) var movies: [MovieModel] = []

    private let moviesRepository: MoviesRepositoryProtocol

    private var nextPageToLoad: Int = 1
    private var cancellables = Set<AnyCancellable>()

    private weak var delegate: MovieListDelegate?

    init(moviesRepository: MoviesRepositoryProtocol, delegate: MovieListDelegate?) {
        self.moviesRepository = moviesRepository
        self.delegate = delegate
    }

    func loadData() {
        guard !state.isLoadingData else { return }

        state = .loading

        fetchMovies(clearLoaded: false)
    }
    
    func onPullToRefresh() {
        guard !state.isLoadingData else {
            state = state
            return
        }

        state = .refreshing
        nextPageToLoad = 1

        fetchMovies(clearLoaded: true)
    }

    func willDisplayMovie(
        at index: Int,
        isCellVisible: Bool,
        isContentBiggerThanTable: Bool
    ) {
        guard !state.isLoadingData else {
            return
        }

        let currentIndexRatio = Double(index) / Double(movies.count)

        if isCellVisible && (currentIndexRatio > 0.7) && isContentBiggerThanTable {
            state = .loadingMore
            fetchMovies(clearLoaded: false)
        }
    }

    func didTapMovie(at index: Int) {
        let movie = movies[index]

        delegate?.didSelect(
            movie: movie,
            onFavoriteDidChange: { [weak self] in
                guard let self else { return }

                self.update(
                    movie: movie,
                    withIsFavorite: self.moviesRepository.isMovieFavorite(movieId: movie.id)
                )

                self.itemIndexToUpdate = index
            }
        )
    }
}

// MARK: - private actions

extension MovieListViewModel {
    private func fetchMovies(clearLoaded: Bool) {
        Task { [weak self] in
            await self?.loadNextPageOfMovies(clearLoaded: clearLoaded)
        }
        .store(in: &cancellables)
    }

    @MainActor
    private func loadNextPageOfMovies(clearLoaded: Bool) async {
        do {
            let fetchedMovies = try await moviesRepository.fetchNowPlayingMovies(
                page: nextPageToLoad
            )

            nextPageToLoad += 1

            if clearLoaded {
                movies = []
            }

            movies += fetchedMovies

            state = movies.isEmpty ? .empty : .loaded
        } catch {
            movies = []
            state = .error(error.localizedDescription)
        }
    }

    private func didTapOnFavoriteButton(movie: MovieModel) {
        if movie.isFavorite {
            moviesRepository.removeMovieFromFavorites(movieId: movie.id)
        } else {
            moviesRepository.addMovieToFavorites(movieId: movie.id)
        }

        update(movie: movie, withIsFavorite: !movie.isFavorite)
    }

    private func update(movie: MovieModel, withIsFavorite isFavorite: Bool) {
        if let movieIndex = movies.firstIndex(where: { $0.id == movie.id }) {
            movies[movieIndex] = movie.copyWith(isFavorite: isFavorite)
        }
    }
}

extension MovieListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCell.reuseIdentifier, for: indexPath) as! MovieListCell

        let movie = movies[indexPath.row]

        cell.set(
            model: movie,
            didTapFavoriteButtonAction: {
                self.didTapOnFavoriteButton(movie: movie)
                tableView.reloadRows(at: [indexPath], with: .none)
            }
        )

        return cell
    }
}
