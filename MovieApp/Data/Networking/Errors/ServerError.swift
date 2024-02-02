//
//  ServerError.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

struct ServerError: Equatable {
    let message: String
    let code: Int
}
