//
//  DIFactory.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Swinject

class DIFactory {
    let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }
}
