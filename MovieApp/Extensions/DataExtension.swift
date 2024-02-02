//
//  DataExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

extension Data {
    var prettyPrintedJson: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else {
            return String(data: self, encoding: .utf8)
        }

        return prettyPrintedString
    }
}
