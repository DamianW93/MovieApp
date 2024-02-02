//
//  Coder.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

enum JSONCoder {
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom(CustomDateDecoder.networkDateDecoder)

        return decoder
    }()

    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.Format.yearMonthDay.rawValue

        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(dateFormatter)

        return encoder
    }()
}
