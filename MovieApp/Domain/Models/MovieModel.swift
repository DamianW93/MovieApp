//
//  MovieModel.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Foundation

struct MovieModel: Identifiable, Equatable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: Date
    let isFavorite: Bool
    let backgroundImagePath: String?
    let posterPath: String?
}

extension MovieModel {
    var smallImageUrl: URL? {
        let imagePath = backgroundImagePath ?? posterPath ?? ""

        return URL(string: NetworkConstants.smallImagePath + imagePath)
    }

    var bigImageUrl: URL? {
        let imagePath = backgroundImagePath ?? posterPath ?? ""

        return URL(string: NetworkConstants.bigImagePath + imagePath)
    }

    static func from(response: MovieDataModel, isFavorite: Bool) -> Self {
        .init(
            id: response.id,
            title: response.title,
            overview: response.overview,
            voteAverage: response.voteAverage,
            releaseDate: response.releaseDate,
            isFavorite: isFavorite,
            backgroundImagePath: response.backdropPath,
            posterPath: response.posterPath
        )
    }

    func copyWith(isFavorite: Bool) -> MovieModel {
        .init(
            id: id,
            title: title,
            overview: overview,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            isFavorite: isFavorite,
            backgroundImagePath: backgroundImagePath,
            posterPath: posterPath
        )
    }
}
