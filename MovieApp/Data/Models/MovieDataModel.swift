//
//  MovieDataModel.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

struct MovieDataModel: Codable, Equatable {
    let id: Int
    let backdropPath: String?
    let posterPath: String?
    let title: String
    let overview: String
    let voteAverage: Double
    let releaseDate: Date
}
