//
//  UserDefault.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Foundation

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    private let userDefaults = UserDefaults.standard

    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.set(newValue, forKey: key)
        }
    }
}
