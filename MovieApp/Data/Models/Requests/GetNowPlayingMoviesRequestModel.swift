//
//  GetNowPlayingMoviesRequestModel.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

struct GetNowPlayingMoviesRequestModel: QueryEncodableRequest {
    let language: String
    let page: String
}
