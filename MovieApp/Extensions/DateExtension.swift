//
//  DateExtension.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 24/01/2024.
//

import Foundation

extension Date {
    private enum FormatterComponents {
        static let formatter = DateFormatter()
    }

    enum Format: String, CaseIterable {
        case yearMonthDay = "YYYY-MM-dd"
    }

    func format(_ style: Format) -> String {
        FormatterComponents.formatter.dateFormat = style.rawValue
        FormatterComponents.formatter.timeZone = Calendar.current.timeZone

        return FormatterComponents.formatter.string(from: self)
    }

    static func from(string: String, with format: Format) throws -> Self {
        FormatterComponents.formatter.dateFormat = format.rawValue
        FormatterComponents.formatter.timeZone = TimeZone(secondsFromGMT: 0)

        guard let date = FormatterComponents.formatter.date(from: string) else {
            throw "Cannot parse string: \(string) to date with format: \(format.rawValue)"
        }

        return date
    }
}
