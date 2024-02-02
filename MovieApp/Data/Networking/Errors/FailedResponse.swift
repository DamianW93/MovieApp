//
//  FailedResponse.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

enum FailedResponse: LocalizedError, Equatable {
    case noInternet
    case badRequest(code: Int)
    case unauthorized
    case server(ServerError)
    case unknown

    var errorDescription: String? {
        switch self {
        case .unknown: return "Unknown error"
        case .unauthorized: return "Unauthorized"
        case .noInternet: return "No internet"
        case .server(let error): return error.message
        case .badRequest(let code): return "Bad request: \(code)"
        }
    }
}
