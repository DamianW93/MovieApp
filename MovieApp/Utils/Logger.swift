//
//  Logger.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

enum Logger {
    static func print(_ object: Any, separator: String? = nil) {
        #if DEBUG
        printSeparatorIfExists(separator)
        Swift.print(object)
        printSeparatorIfExists(separator)
        #endif
    }

    static func print(_ object: Any..., separator: String? = nil) {
        #if DEBUG
        printSeparatorIfExists(separator)
        object.forEach { Swift.print($0) }
        printSeparatorIfExists(separator)
        #endif
    }

    private static func printSeparatorIfExists(_ separator: String?) {
        guard let separator = separator else {
            return
        }

        Swift.print(separator)
    }
}
