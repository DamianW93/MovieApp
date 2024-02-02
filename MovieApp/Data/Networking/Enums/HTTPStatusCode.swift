//
//  HTTPStatusCode.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

enum HTTPStatusCodes {
    static let successCodes = 200..<300
    static let badRequest = 400
    static let unauthorized = 401
    static let clientErrors = 402...499
    static let notFound = 404
    static let serverErrors = 500...599
}
