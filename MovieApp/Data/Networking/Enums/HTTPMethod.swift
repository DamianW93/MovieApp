//
//  HTTPMethod.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

enum HTTPMethod {
    case get([URLQueryItem]? = nil)
    case post(Data? = nil)
    case put(Data? = nil)
    case patch
    case delete
}

extension HTTPMethod {
    var name: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}
