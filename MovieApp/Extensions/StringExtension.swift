//
//  StringExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 24/01/2024.
//

import Foundation

// Allows to throw plain string without wrapping in error model
extension String: LocalizedError {
    public var errorDescription: String? {
        self
    }
}
