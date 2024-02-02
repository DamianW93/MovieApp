//
//  MoviesEndpoint.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

enum MoviesEndpoint: Endpoint {
    case getPlayingNowMovies(GetNowPlayingMoviesRequestModel)

    var path: String {
        switch self {
        case .getPlayingNowMovies: return "movie/now_playing"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPlayingNowMovies(let requestModel): return .get(requestModel.queryItems)
        }
    }
}
