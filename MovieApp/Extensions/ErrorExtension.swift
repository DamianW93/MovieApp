//
//  ErrorExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

extension Error {
    var asFailedResponse: FailedResponse {
        if let failedResponse = self as? FailedResponse {
            return failedResponse
        } else {
            let code = (self as NSError).code

            switch code {
            case NSURLErrorNotConnectedToInternet: return .noInternet
            default: return .server(.init(message: self.localizedDescription, code: code))
            }
        }
    }
}
