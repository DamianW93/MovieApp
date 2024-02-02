//
//  RepositoriesAssembly.swift
//  MovieApp
//
//  Created by Damian Włodarczyk on 22/01/2024.
//

import Swinject
import SwinjectAutoregistration

final class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container
            .autoregister(MoviesRepositoryProtocol.self, initializer: MoviesRepository.init)
            .inObjectScope(.container)
    }
}
