//
//  URLSessionProtocol.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
