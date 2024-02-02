//
//  QueryEncodableRequest.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

protocol QueryEncodableRequest: Encodable {}

extension QueryEncodableRequest {
    var queryItems: [URLQueryItem] {
        guard let dictionary = try? asDictionary() else { return [] }

        return dictionary
            .map { ($0.key, $0.value as? String) }
            .map(URLQueryItem.init)
    }
}
