//
//  FactoriesAssembly.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 21/01/2024.
//

import Swinject

final class FactoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(MovieListModuleFactoryProtocol.self, factory: MovieListModuleFactory.init)
    }
}
