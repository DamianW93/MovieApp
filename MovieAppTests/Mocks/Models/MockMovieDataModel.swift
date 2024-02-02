//
//  MockMovieDataModel.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

import Foundation

@testable import MovieApp

enum MockMovieDataModel {
    static let mocked: MovieDataModel = .init(
        id: 1,
        backdropPath: "/yOm993lsJyPmBodlYjgpPwBjXP9.jpg",
        posterPath: "/qhb1qOilapbapxWQn9jtRCMwXJF.jpg",
        title: "Wonka", 
        overview: "Willy Wonka – chock-full of ideas and determined to change the world one delectable bite at a time – is proof that the best things in life begin with a dream, and if you’re lucky enough to meet Willy Wonka, anything is possible.",
        voteAverage: 7.187,
        releaseDate: (try? Date.from(string: "2023-12-06", with: .yearMonthDay)) ?? Date()
    )
}
