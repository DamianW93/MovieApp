//
//  MockUrlSessionProtocol.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

import Foundation

@testable import MovieApp

final class MockURLSessionProtocol: URLSessionProtocol {
    private(set) var dataForRequestCalled: Bool = false
    private(set) var dataForArgument: URLRequest?

    var dataForRequestReturnValue: (Data, URLResponse)?
    var dataForRequestError: Error?

    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        dataForRequestCalled = true
        dataForArgument = request

        if let dataForRequestReturnValue {
            return dataForRequestReturnValue
        } else if let dataForRequestError {
            throw dataForRequestError
        } else {
            return (Data(), HTTPURLResponse())
        }
    }
}
