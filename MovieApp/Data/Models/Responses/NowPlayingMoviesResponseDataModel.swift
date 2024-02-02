//
//  MovieListResponseDataModel.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

struct NowPlayingMoviesResponseDataModel: Codable {
    let results: [MovieDataModel]
}
