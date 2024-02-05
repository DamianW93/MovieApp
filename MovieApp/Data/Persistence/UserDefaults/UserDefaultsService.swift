//
//  UserDefaultsService.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func isMovieFavorite(movieId: Int) -> Bool
    func addMovieToFavorites(movieId: Int)
    func removeMovieFromFavorites(movieId: Int)
}

final class UserDefaultsService: UserDefaultsServiceProtocol {
    @UserDefault(key: "com.movieApp.userDefaults.favorites", defaultValue: [])
    private var favorites: [Int]

    func isMovieFavorite(movieId: Int) -> Bool {
        favorites.contains(movieId)
    }

    func addMovieToFavorites(movieId: Int) {
        favorites.append(movieId)
    }

    func removeMovieFromFavorites(movieId: Int) {
        favorites.removeAll {
            $0 == movieId
        }
    }
}
