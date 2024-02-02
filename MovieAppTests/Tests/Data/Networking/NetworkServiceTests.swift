//
//  NetworkServiceTests.swift
//  MovieAppTests
//
//  Created by Damian Włodarczyk on 27/01/2024.
//

import XCTest
@testable import MovieApp

final class NetworkServiceTests: XCTestCase {
    private var sut: NetworkService!

    private var urlSession: MockURLSessionProtocol!
    private var jsonDecoder: JSONDecoder!

    override func setUp() {
        super.setUp()

        urlSession = MockURLSessionProtocol()
        jsonDecoder = JSONCoder.decoder

        sut = NetworkService(urlSession: urlSession, jsonDecoder: jsonDecoder)
    }

    func testRequest_callsSessionToFetchData() async throws {
        /// Given
        let mockedResponse: [MovieDataModel] = [MockMovieDataModel.mocked, MockMovieDataModel.mocked]
        let data = try JSONCoder.encoder.encode(mockedResponse)

        urlSession.dataForRequestReturnValue = (
            data,
            HTTPURLResponse(
                url: URL(string: "https://www.test.com")!,
                statusCode: 200,
                httpVersion: "",
                headerFields: [:]
            )!
        )

        let mockEndpoint = MoviesEndpoint.getPlayingNowMovies(
            GetNowPlayingMoviesRequestModel(language: "en", page: "1")
        )

        /// When
        _ = try await sut.request(type: [MovieDataModel].self, endpoint: mockEndpoint)

        /// Then
        XCTAssertTrue(urlSession.dataForRequestCalled)
    }

    func testRequest_returnsUnknownError_WhenResponseIsNotHttpURLResponse() async throws {
        /// Given
        urlSession.dataForRequestReturnValue = (Data(), URLResponse())

        let mockEndpoint = MoviesEndpoint.getPlayingNowMovies(
            GetNowPlayingMoviesRequestModel(language: "en", page: "1")
        )

        do {
            /// When
            _ = try await sut.request(type: [MovieDataModel].self, endpoint: mockEndpoint)

            /// Then
            XCTFail("Request did not throw error")
        } catch {
            XCTAssertEqual(error as? FailedResponse, FailedResponse.unknown)
        }
    }

    func testRequest_ReturnsResponseModel_WhenSucceeds() async throws {
        /// Given
        let mockedResponse: [MovieDataModel] = [MockMovieDataModel.mocked, MockMovieDataModel.mocked]
        let data = try JSONCoder.encoder.encode(mockedResponse)

        urlSession.dataForRequestReturnValue = (
            data,
            HTTPURLResponse(
                url: URL(string: "https://www.test.com")!,
                statusCode: 200,
                httpVersion: "",
                headerFields: [:]
            )!
        )

        let mockEndpoint = MoviesEndpoint.getPlayingNowMovies(
            GetNowPlayingMoviesRequestModel(language: "en", page: "1")
        )

        /// When
        let response = try await sut.request(type: [MovieDataModel].self, endpoint: mockEndpoint)

        /// Then
        XCTAssertEqual(response, mockedResponse)
    }

    func testRequest_ReturnsUnauthorizedError_WhenBackendReturns401() async throws {
        /// Given
        urlSession.dataForRequestReturnValue = (
            Data(),
            HTTPURLResponse(
                url: URL(string: "https://www.test.com")!,
                statusCode: 401,
                httpVersion: "",
                headerFields: [:]
            )!
        )

        let mockEndpoint = MoviesEndpoint.getPlayingNowMovies(
            GetNowPlayingMoviesRequestModel(language: "en", page: "1")
        )

        do {
            /// When
            _ = try await sut.request(type: [MovieDataModel].self, endpoint: mockEndpoint)

            /// Then
            XCTFail("Request did not throw error")
        } catch {
            XCTAssertEqual(error as? FailedResponse, FailedResponse.unauthorized)
        }
    }

    func testRequest_ReturnsRequestError_WhenBackendReturnsRequestError() async throws {
        /// Given
        urlSession.dataForRequestReturnValue = (
            Data(),
            HTTPURLResponse(
                url: URL(string: "https://www.test.com")!,
                statusCode: 405,
                httpVersion: "",
                headerFields: [:]
            )!
        )

        let mockEndpoint = MoviesEndpoint.getPlayingNowMovies(
            GetNowPlayingMoviesRequestModel(language: "en", page: "1")
        )

        do {
            /// When
            _ = try await sut.request(type: [MovieDataModel].self, endpoint: mockEndpoint)

            /// Then
            XCTFail("Request did not throw error")
        } catch {
            XCTAssertEqual(error as? FailedResponse, FailedResponse.badRequest(code: 405))
        }
    }

    func testRequest_ReturnsServerError_WhenBackendFailed() async throws {
        /// Given
        urlSession.dataForRequestReturnValue = (
            Data(),
            HTTPURLResponse(
                url: URL(string: "https://www.test.com")!,
                statusCode: 500,
                httpVersion: "",
                headerFields: [:]
            )!
        )

        let mockEndpoint = MoviesEndpoint.getPlayingNowMovies(
            GetNowPlayingMoviesRequestModel(language: "en", page: "1")
        )

        do {
            /// When
            _ = try await sut.request(type: [MovieDataModel].self, endpoint: mockEndpoint)

            /// Then
            XCTFail("Request did not throw error")
        } catch {
            XCTAssertEqual(
                error as? FailedResponse,
                FailedResponse.server(
                    .init(
                        message: HTTPURLResponse.localizedString(forStatusCode: 500),
                        code: 500
                    )
                )
            )
        }
    }
}
