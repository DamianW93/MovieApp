//
//  NetworkConstants.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

enum NetworkConstants {
    static let apiUrl = "https://api.themoviedb.org/3/"
    static let accessToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4YzU4MWQ4N2ViMWMxYzg5NTgxNjM5YzBlZmE5M2IwNSIsInN1YiI6IjU4N2JjMTUwYzNhMzY4NDlmZjAxMDVjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.n7wcIjin09gKX0IQnv-ZvicpCN7p7EnUbawI-VkB5XU"

    static let acceptHeader = "Accept"
    static let authorizationHeader = "Authorization"
    static let acceptHeaderValue = "application/json"
    static let contentTypeHeader = "Content-Type"
    static let contentTypeHeaderValue = acceptHeaderValue

    static let smallImagePath = "https://image.tmdb.org/t/p/w500"
    static let bigImagePath = "https://image.tmdb.org/t/p/original"
}
