//
//  CustomDateDecoder.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 24/01/2024.
//

import Foundation

enum CustomDateDecoder {
    static let networkDateDecoder: (Decoder) throws -> Date = { decoder -> Date in
        let container = try decoder.singleValueContainer()
        let dateString = try container.decode(String.self)

        guard let date = Date.Format.allCases
                .lazy
                .compactMap({ try? Date.from(string: dateString, with: $0) })
                .first else {
            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Cannot decode date string \(dateString)"
            )
        }

        return date
    }
}
