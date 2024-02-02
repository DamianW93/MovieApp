//
//  NetworkService.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(type: T.Type, endpoint: Endpoint) async throws-> T
}

final class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSessionProtocol
    private let jsonDecoder: JSONDecoder

    init(urlSession: URLSessionProtocol, jsonDecoder: JSONDecoder) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }

    func request<T: Decodable>(type: T.Type, endpoint: Endpoint) async throws -> T {
        let urlRequest = endpoint.buildRequest()

        do {
            let (data, response) = try await urlSession.data(for: urlRequest)

            return try handleResponse(response, data: data)
        } catch {
            throw error.asFailedResponse
        }
    }

    private func handleResponse<T: Decodable>(_ response: URLResponse, data: Data) throws -> T {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw FailedResponse.unknown
        }

        switch httpResponse.statusCode {
        case HTTPStatusCodes.successCodes:
            return try jsonDecoder.decode(T.self, from: data)
        case HTTPStatusCodes.unauthorized:
            throw FailedResponse.unauthorized
        case HTTPStatusCodes.badRequest, HTTPStatusCodes.clientErrors:
            throw FailedResponse.badRequest(code: httpResponse.statusCode)
        case HTTPStatusCodes.serverErrors:
            throw FailedResponse.server(
                .init(
                    message: HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode),
                    code: httpResponse.statusCode
                )
            )
        default:
            throw FailedResponse.unknown
        }
    }
}
