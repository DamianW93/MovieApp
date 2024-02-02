//
//  EncodableExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONCoder.encoder.encode(self)

        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }

        return dictionary
    }
}
